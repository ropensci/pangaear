#' Download data from Pangaea.
#'
#' Grabs data as a dataframe or list of dataframes from a Pangaea data
#' repository URI; see: <https://www.pangaea.de/>
#'
#' @export
#' @param doi DOI of Pangaeae single dataset, or of a collection of datasets.
#' Expects either just a DOI of the form `10.1594/PANGAEA.746398`, or with
#' the URL part in front, like
#' <https://doi.pangaea.de/10.1594/PANGAEA.746398>
#' @param overwrite (logical) Ovewrite a file if one is found with the same name
#' @param mssgs (logical) print information messages. Default: `TRUE`
#' @param ... Curl options passed on to [crul::verb-GET]
#' @return One or more items of class pangaea, each with the doi, parent doi
#' (if many dois within a parent doi), url, citation, path, and data object.
#' Data object depends on what kind of file it is. For tabular data, we print
#' the first 10 columns or so; for a zip file we list the files in the zip
#' (but leave it up to the user to dig unzip and get files from the zip file);
#' for png files, we point the user to read the file in with [png::readPNG()]
#' @author Naupaka Zimmerman, Scott Chamberlain
#' @references <https://www.pangaea.de>
#' @details Data files are stored in an operating system appropriate location.
#' Run `pg_cache$cache_path_get()` to get the storage location
#' on your machine. See [pg_cache] for more information, including how to
#' set a different base path for downloaded files.
#'
#' Some files/datasets require the user to be logged in. For now we
#' just pass on these - that is, give back nothing other than metadata.
#' @examples \dontrun{
#' # a single file
#' (res <- pg_data(doi='10.1594/PANGAEA.807580'))
#' res[[1]]$doi
#' res[[1]]$citation
#' res[[1]]$data
#' res[[1]]$metadata
#'
#' # another single file
#' pg_data(doi='10.1594/PANGAEA.807584')
#'
#' # Many files
#' (res <- pg_data(doi='10.1594/PANGAEA.761032'))
#' res[[1]]
#' res[[2]]
#'
#' # Manipulating the cache
#' ## list files in the cache
#' pg_cache$list()
#'
#' ## clear all data
#' # pg_cache$delete_all()
#' pg_cache$list()
#'
#' ## clear a single dataset by DOI
#' pg_data(doi='10.1594/PANGAEA.812093')
#' pg_cache$list()
#' path <- grep("PANGAEA.812093", pg_cache$list(), value = TRUE)
#' pg_cache$delete(path)
#' pg_cache$list()
#'
#' # search for datasets, then pass in DOIs
#' (searchres <- pg_search(query = 'birds', count = 20))
#' pg_data(searchres$doi[1])
#'
#' # png file
#' pg_data(doi = "10.1594/PANGAEA.825428")
#'
#' # zip file
#' pg_data(doi = "10.1594/PANGAEA.860500")
#'
#' # login required
#' ## we skip file download
#' pg_data("10.1594/PANGAEA.788547")
#' }

pg_data <- function(doi, overwrite = TRUE, mssgs = TRUE, ...) {
  dois <- check_many(doi)
  citation <- attr(dois, "citation")
  if (mssgs) message("Downloading ", length(dois), " datasets from ", doi)
  invisible(lapply(dois, function(x) {
    if ( !is_pangaea(pg_cache$cache_path_get(), x) ) {
      pang_GET(url = paste0(base(), x), doi = x, overwrite, ...)
    }
  }))
  if (mssgs) message("Processing ", length(dois), " files")
  out <- process_pg(dois, doi, citation)
  lapply(out, structure, class = "pangaea")
}

#' @export
print.pangaea <- function(x, ...) {
  cat(sprintf("<Pangaea data> %s", x$doi), sep = "\n")
  cat(sprintf("  parent doi: %s", x$parent_doi), sep = "\n")
  cat(sprintf("  url:        %s", x$url), sep = "\n")
  cat(sprintf("  citation:   %s", x$citation), sep = "\n")
  cat(sprintf("  path:       %s", x$path), sep = "\n")
  cat("  data:", sep = "\n")
  print(x$data)
}

pang_GET <- function(url, doi, overwrite, ...){
  bpath <- pg_cache$cache_path_get()
  dir.create(bpath, showWarnings = FALSE, recursive = TRUE)

  cli <- crul::HttpClient$new(url = url,
    opts = list(followlocation = TRUE, ...))
  res <- cli$get(query = list(format = "textfile"))
  res$raise_for_status()

  # remove spaces in content type header, if present
  # so we can keep the below code the same
  res$response_headers$`content-type` <- 
    gsub("\\s", "", res$response_headers$`content-type`)

  # if login required, stop with just metadata
  if (grepl("text/html", res$response_headers$`content-type`)) {
    if (
      grepl("Log in",
            xml2::xml_text(
              xml2::xml_find_first(xml2::read_html(res$parse("UTF-8")), "//title")))
    ) {
      warning("Log in required, skipping file download", call. = FALSE)
      return()
    }
  }

  fname <- rdoi(
    doi,
    switch(
      res$response_headers$`content-type`,
      `image/png` = ".png",
      `text/tab-separated-values;charset=UTF-8` = ".txt",
      `application/zip` = ".zip"
    )
  )
  switch(
    res$response_headers$`content-type`,
    `image/png` = png::writePNG(png::readPNG(res$content), file.path(bpath, fname)),
    `text/tab-separated-values;charset=UTF-8` = {
      writeLines(res$parse("UTF-8"), file.path(bpath, fname))
    },
    `application/zip` = {
      path <- file(file.path(bpath, fname), "wb")
      writeBin(res$content, path)
      close(path)
    }
  )
}

process_pg <- function(x, doi, citation) {
  lapply(x, function(m) {
    file <- list.files(pg_cache$cache_path_get(), pattern = gsub("/|\\.", "_", m),
                       full.names = TRUE)
    if (length(file) == 0) {
      list(
        parent_doi = doi,
        doi = m,
        citation = citation,
        url = paste0("https://doi.org/", m),
        path = NA,
        metadata = NA,
        data = NA
      )
    } else {
      list(
        parent_doi = doi,
        doi = m,
        citation = citation,
        url = paste0("https://doi.org/", m),
        path = file,
        metadata = read_meta(file),
        data = {
          ext <- strsplit(basename(file), "\\.")[[1]][2]
          switch(
            ext,
            zip = utils::unzip(file, list = TRUE),
            txt = {
              dat <- read_csv(file)
              tibble::as_tibble(dat, .name_repair = "minimal")
            },
            png = "png; read with png::readPNG()"
          )
        }
      )
    }
  })
}

is_pangaea <- function(x, doi){
  lf <- list.files(x)
  if ( identical(lf, character(0)) ) { FALSE } else {
    doipaths <- unname(vapply(lf, function(z) strsplit(z, "\\.")[[1]][1], ""))
    any(strsplit(rdoi(doi), "\\.")[[1]][1] %in% doipaths)
  }
}

rdoi <- function(x, ext = ".txt") paste0(gsub("/|\\.", "_", x), ext)

check_many <- function(x) {
  res <- crul::HttpClient$new(url = fix_doi(x))$get()
  txt <- xml2::read_html(res$parse("UTF-8"))
  dc_format <- xml2::xml_attr(
    xml2::xml_find_first(txt, "//meta[@name=\"DC.format\"]"), "content")
  cit <- xml2::xml_attr(
    xml2::xml_find_first(txt, "//meta[@name=\"description\"]"), "content")
  attr(x, "citation") <- cit

  if (grepl("zip", dc_format) && !grepl("datasets", dc_format)) {
    # zip files
    return(x)
  } else if (
    # single dataset
    unique(xml2::xml_length(
      xml2::xml_find_all(
        txt,
        ".//a[@rel=\"follow\"]"
      )
    )) == 0
  ) {
    return(x)
  } else {
    # many datasets
    tmp <- gsub(
      "https://doi.pangaea.de/", "",
      xml2::xml_attr(
        xml2::xml_find_all(txt,
          ".//a[@rel=\"follow\"]"
        ),
        "href"
      )
    )
    attr(tmp, "citation") <- cit
    return(tmp)
  }
}

fix_doi <- function(x) {
  if (grepl("https?://doi.pangaea.de/?", x)) {
    x
  } else {
    # make sure doi is cleaned up before making a url
    if (!grepl("^10.1594", x)) {
      stop(x, " not of right form, expecting a DOI, see pg_data help file",
           call. = FALSE)
    }
    paste0(base(), x)
  }
}
