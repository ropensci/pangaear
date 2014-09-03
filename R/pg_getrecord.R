#' Get record from the Pangaea repository
#'
#' @export
#' @import OAIHarvester
#' @param identifier description
#' @param transform logical;
#'
#' @examples \dontrun{
#' record <- pg_getrecord(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#' head(record)
#' }

pg_getrecord <- function(Identifier, transform = TRUE){
  baseurl <- "http://ws.pangaea.de/oai/"
  oaih_get_record(baseurl, identifier = identifier, transform = transform)
}
