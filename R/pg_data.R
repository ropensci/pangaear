#' Download data from Pangaea.
#'
#' Grabs data as a dataframe or list of dataframes from a Pangaea data
#' repository URI; see: \url{https://www.pangaea.de/}.
#'
#' @export
#' @param doi DOI of Pangaeae single dataset, or of a collection of datasets.
#' Expects either just a DOI of the form \code{10.1594/PANGAEA.746398}, or with
#' the URL part in front, like
#' \code{https://doi.pangaea.de/10.1594/PANGAEA.746398}
#' @param overwrite (logical) Ovewrite a file if one is found with the same name
#' @param verbose (logical) print information messages. Default: \code{TRUE}
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @param prompt (logical) Prompt before clearing all files in cache? No prompt
#' used when DOIs assed in. Default: \code{TRUE}
#' @return One or more items of class pangaea, each with a citation object,
#' metadata object, and data object. Each data object is printed as a
#' \code{tbl_df} object, but the actual object is simply a \code{data.frame}.
#' @author Naupaka Zimmerman
#' @references \url{https://www.pangaea.de}
#' @details Data files are stored in an operating system appropriate location.
#' Run \code{rappdirs::user_cache_dir("pangaear")} to get the storage location
#' on your machine.
#' @examples \dontrun{
#' # a single file
#' res <- pg_data(doi='10.1594/PANGAEA.807580')
#' res
#' res[[1]]$doi
#' res[[1]]$citation
#' res[[1]]$meta
#' res[[1]]$data
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
#' pg_cache_list()
#'
#' ## clear all data
#' # pg_cache_clear()
#' pg_cache_list()
#'
#' ## clear a single dataset by DOI
#' pg_data(doi='10.1594/PANGAEA.812093')
#' pg_cache_list()
#' pg_cache_clear(doi='10.1594/PANGAEA.812093')
#' pg_cache_list()
#'
#' ## clear more than 1 dataset by DOI
#' lapply(c('10.1594/PANGAEA.746398','10.1594/PANGAEA.746400'), pg_data)
#' pg_cache_list()
#' pg_cache_clear(doi=c('10.1594/PANGAEA.746398','10.1594/PANGAEA.746400'))
#' pg_cache_list()
#'
#' # search for datasets, then pass in DOIs
#' res <- pg_search(query='water', count=20)
#' pg_data(res$doi[1])
#' pg_data(res$doi[2])
#' pg_data(res$doi[3])
#' pg_data(res$doi[4])
#' pg_data(res$doi[5])
#' }

pg_data <- function(doi, overwrite = TRUE, verbose = TRUE, ...) {
  dois <- check_many(doi)
  if (verbose) message("Downloading ", length(dois), " datasets from ", doi)
  invisible(lapply(dois, function(x) {
    if ( !is_pangaea(env$path, x) ) {
      pang_GET(url = paste0(base(), x), doi = x, overwrite, ...)
    }
  }))
  if (verbose) message("Processing ", length(dois), " files")
  out <- process_pg(dois)
  lapply(out, structure, class = "pangaea")
}

#' @export
print.pangaea <- function(x, ...) {
  cat(sprintf("<Pangaea data> %s", x$doi), sep = "\n")
  print(x$data)
}

print.meta <- function(x, ...){
  cat(x$meta, sep = "\n")
}

print.citation <- function(x, ...){
  cat(x$citation, sep = "\n")
}

pang_GET <- function(url, doi, overwrite, ...){
  dir.create(env$path, showWarnings = FALSE, recursive = TRUE)
  fname <- rdoi(doi)
  res <- httr::GET(url,
             query = list(format = "textfile"),
             httr::config(followlocation = TRUE),
             httr::write_disk(file.path(env$path, fname), overwrite), ...)
  httr::stop_for_status(res)
}

process_pg <- function(x){
  lapply(x, function(m){
    file <- file.path(env$path, rdoi(m))
    list(
      doi = m,
      citation = pg_citation(m),
      meta = get_meta(file),
      data = {
        dat <- read_csv(file)
        as_data_frame(dat, validate = FALSE)
      }
    )
  })
}

pg_citation <- function(x){
  structure(list(
    citation = sprintf('See https://doi.pangaea.de/%s for the citation', x)),
            class = "citation")
}

is_pangaea <- function(x, doi){
  if ( identical(list.files(x), character(0)) ) { FALSE } else {
    if ( any(rdoi(doi) %in% list.files(x)) ) TRUE else FALSE
  }
}

get_meta <- function(x){
  lns <- readLines(x, n = 1000)
  ln_no <- grep("\\*/", lns) - 1
  use <- lns[2:ln_no]
  structure(list(meta = use), class = "meta")
}

rdoi <- function(x, ext = ".txt") paste0(gsub("/|\\.", "_", x), ext)

check_many <- function(x){
  res <- httr::GET(fix_doi(x))
  txt <- xml2::read_html(cuf8(res))
  if (!grepl(
    "zip",
    xml_attr(xml_find_first(txt, "//meta[@name=\"DC.format\"]"), "content")
  )) {
    x
  } else {
    gsub("https://doi.pangaea.de/", "", xml_attr(
      xml_find_all(txt, ".//div[@class=\"MetaHeaderItem\"]//a[@rel=\"follow\"]"),
      "href"
    ))
  }
}

fix_doi <- function(x) {
  if (grepl("https?://doi.pangaea.de/?", x)) {
    x
  } else {
    # make sure doi is cleaned up before making a url
    if (!grepl("^10.1594", x)) stop(x, " not of right form, expecting a DOI, see pg_data help file", call. = FALSE)
    paste0(base(), x)
  }
}
