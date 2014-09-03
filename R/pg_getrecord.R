#' Get record from the Pangaea repository
#'
#' @export
#' @import OAIHarvester
#' @param
#'
#' @examples \dontrun{
#' record <- pg_getrecord(Identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#' hed(record)
#' }

pg_getrecord <- function(Identifier, transform = TRUE){
  baseurl <- "http://ws.pangaea.de/oai/"
  oaih_get_record(baseurl, identifier = Identifier, transform = transform)
}
