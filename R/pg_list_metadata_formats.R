#' Get metadata formats from the Pangaea repository
#'
#' @export
#' @param ... Curl debugging options passed on to \code{\link[httr]{GET}}
#'
#' @examples \dontrun{
#' pg_list_metadata_formats()
#' }
pg_list_metadata_formats <- function(...) {
  oai::list_metadataformats(url = baseoai(), ...)
  # res <- pg_GET(args = list(verb="ListMetadataFormats"), ...)
  # data.frame(do.call(rbind, res), stringsAsFactors = FALSE)
}
