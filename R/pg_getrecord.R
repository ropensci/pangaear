#' Get record from the Pangaea repository
#'
#' @export
#' @import OAIHarvester
#' @param
#'
#' @examples
#' pg_getrecord()

pg_getrecord <- function(Identifier, transform = TRUE){
  baseurl <- "http://ws.pangaea.de/oai/"
  oaih_get_record(baseurl, identifier = Identifier, transform = transform)
}
