#' Identify information about the Pangaea repository
#'
#' @export
#' @import OAIHarvester
#' @param transform A logical indicating whether the OAI-PMH XML results to “useful” R data
#' structures via oaih_transform. Default: true.
#'
#' @examples \dontrun{
#' pg_identify()
#' }
#'

pg_identify <- function(transform = TRUE) {
  url <- "http://ws.pangaea.de/oai"
  tmp <- oaih_identify(url, transform = transform)
  if (transform == TRUE) {
    tmp$description <- oaih_transform(tmp$description[[1L]])
 }
 return(tmp)
}
