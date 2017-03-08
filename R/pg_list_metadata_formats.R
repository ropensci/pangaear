#' Get metadata formats from the Pangaea repository
#'
#' @export
#' @param ... Curl debugging options passed on to [httr::GET()]
#' @return data.frame
#' @references [OAI-PMH documentation](https://www.openarchives.org/pmh/)
#' @examples \dontrun{
#' pg_list_metadata_formats()
#' }
pg_list_metadata_formats <- function(...) {
  oai::list_metadataformats(url = baseoai(), ...)
}
