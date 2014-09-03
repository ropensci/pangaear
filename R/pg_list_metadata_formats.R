#' Get metadata formats from the Pangaea repository
#'
#' @export
#' @import OAIHarvester
#' @param
#'
#' @examples
#' pg_list_metadata_formats()

pg_list_metadata_formats <- function(){
  baseurl <- "http://ws.pangaea.de/oai/"
  formats <- oaih_list_metadata_formats(baseurl)
  data.frame(formats)
}
