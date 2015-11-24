#' Download data from Pangaea.
#'
#' Grabs data as a dataframe or list of dataframes from a Pangaea data repository URI; see:
#' \url{http://www.pangaea.de/}.
#'
#' @export
#' @param doi DOI of Pangaeae single dataset, or of a collection of datasets.
#' @param path (character) Path to store files in. Default: \emph{"~/.pangaea/"}
#' @param overwrite (logical) Ovewrite a file if one is found with the same name
#' @param ... Curl debugging options passed on to \code{\link[httr]{GET}}
#' @param prompt (logical) Prompt before clearing all files in cache? No prompt used when DOIs
#' assed in. Default: TRUE
#' @return One or more items of class pangaea, each with a citation object, metadata object,
#' and data object. Each data object is printed as a \code{tbl_df} object, but the
#' actual object is simply a \code{data.frame}.
#' @author Naupaka Zimmerman
#' @examples \dontrun{
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
#' }

pg_data <- function(doi, path="~/.pangaea/", overwrite=TRUE, ...)
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

#' @export
#' @rdname pg_data
pg_cache_clear <- function(path="~/.pangaea/", doi=NULL, prompt=TRUE){
  if(is.null(doi)){
    files <- list.files(path, full.names = TRUE)
    resp <- if(prompt) readline(sprintf("Sure you want to clear all %s files? [y/n]:  ", length(files))) else "y"
    if(resp == "y") unlink(files, force = TRUE) else NULL
  } else {
    files <- file.path(path, rdoi(doi))
    unlink(files, force = TRUE)
  }
}

#' @export
#' @rdname pg_data
pg_cache_list <- function(path="~/.pangaea/") list.files(path)

pang_GET <- function(bp, url, doi, overwrite){
  dir.create(bp, showWarnings = FALSE, recursive = TRUE)
  fname <- rdoi(doi)
  res <- GET(url,
             query=list(format="textfile", charset="UTF-8"),
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
