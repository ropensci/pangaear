#' Download data from Pangaea.
#'
#' Grabs data as a dataframe or list of dataframes from a Pangaea data repository URI; see:
#' \url{http://www.pangaea.de/}.
#'
#' @export
#' @importFrom httr write_disk
#'
#' @param doi DOI of Pangaeae dataset
#' @param write (logical) Write dataset to disk or read into memory (the R session). Default: TRUE
#' @param path (character) Path to store files in. Default: \emph{"~/.pangaea/"}
#' @param overwrite (logical) Ovewrite a file if one is found with the same name
#' @param ... Curl debugging options passed on to \code{\link[httr]{GET}}
#'
#' @return dataframe with rows of data, list of dataframes with rows of data if there are multiple
#' related data sets found at the URI
#' @author Naupaka Zimmerman
#' @examples \donttest{
#' # a single file
#' res <- pg_data(doi='10.1594/PANGAEA.807580')
#' res
#' res[[1]]$citation
#' res[[1]]$meta
#'
#' # another single file
#' pg_data(doi='10.1594/PANGAEA.807584')
#'
#' # Many files
#' res <- pg_data(doi='10.1594/PANGAEA.807587')
#' res[[3]]
#'
#' # Another example of many files
#' res <- pg_data(doi='10.1594/PANGAEA.761032')
#' res[[1]]
#' res[[2]]
#' }

pg_data <- function(doi, write=TRUE, path="~/.pangaea/", overwrite=TRUE, ...)
{
  dois <- check_many(doi)
  invisible(lapply(dois, function(x){
    if( !is_pangaea(path.expand(path), x) ){
      pang_GET(bp = path, url = paste0(base(), x), doi = x, overwrite)
    }
  }))
  out <- process_pg(path, dois)
  lapply(out, structure, class="pangaea")
}

#' @export
print.pangaea <- function(x, ..., n = 10){
  cat(sprintf("<Pangaea data> %s", x$doi), sep = "\n")
  trunc_mat(x$data, n = n)
}

print.meta <- function(x, ...){
  cat(x$meta, sep = "\n")
}

print.citation <- function(x, ...){
  cat(x$citation, sep = "\n")
}

pang_GET <- function(bp, url, doi, overwrite){
  dir.create(bp, showWarnings = FALSE, recursive = TRUE)
  fname <- rdoi(doi)
  res <- GET(url,
             query=list(format="textfile"),
             config(followlocation = TRUE),
             write_disk(file.path(bp, fname), overwrite))
  stop_for_status(res)
}

process_pg <- function(bp, x){
  lapply(x, function(m){
    list(doi=m,
         citation=pg_citation(m),
         meta=get_meta(file.path(bp, rdoi(m))),
         data=read_csv(file.path(bp, rdoi(m)))
    )
  })
}

pg_citation <- function(x){
  structure(list(citation=sprintf('See http://doi.pangaea.de/%s for the citation', x)), class="citation")
}

is_pangaea <- function(x, doi){
  if( identical(list.files(x), character(0)) ) { FALSE } else {
    if( any(rdoi(doi) %in% list.files(x)) ) TRUE else FALSE
  }
}

get_meta <- function(x){
  lns <- readLines(x, n = 300)
  ln_no <- grep("\\*/", lns) - 1
  use <- lns[2:ln_no]
  structure(list(meta=use), class="meta")
#   toget <- c('Citation','Related to','Project','Coverage','Event','Parameter','License','Size')
#   lapply(toget, function(z){
#     grep(z, use, value = TRUE)
#   })
}

rdoi <- function(x) paste0(gsub("/|\\.", "_", x), ".txt")

check_many <- function(x){
  res <- GET(paste0(base(), x))
  if(!grepl("name=\"dslist\"", content(res, "text"))){ x } else {
    d <- gregexpr("<div class=\"MetaHeaderItem\"><a rel=\"follow\" href=\"(http://doi.pangaea.de/.*?)\">", res)
    d <- unlist(regmatches(content(res, "text"), d))
    split_d <- strsplit(d, split = "\"")
    vapply(split_d, function (x) sub("http://doi.pangaea.de/", "", x[grepl("doi",x)]), "")
  }
}
