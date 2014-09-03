#' Get metadata formats from the Pangaea repository
#'
#' @export
#' @importFrom OAIHarvester oaih_list_metadata_formats
#'
#' @examples
#' pg_list_metadata_formats()

pg_list_metadata_formats <- function(){
  baseurl <- "http://ws.pangaea.de/oai/"
  formats <- oaih_list_metadata_formats(baseurl)
  data.frame(formats)
}
