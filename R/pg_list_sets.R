#' List the set structure of the Pangaea repository
#'
#' @export
#' @importFrom OAIHarvester oaih_list_sets
#' @importFrom RCurl getURLContent
#' @importFrom XML xmlParse
#' @param transform logical; whether the OAI-PMH XML results to \emph{useful} R data
#' structures via \code{link{oaih_transform}}. Default: \code{TRUE}.
#'
#' @examples \donttest{
#' pg_list_sets()
#' }


pg_list_sets <- function(transform = TRUE) {
  url <- "http://ws.pangaea.de/oai"
  verb <- "ListSets"
  if (transform == TRUE) {
    tmp <- oaih_list_sets(url, transform = transform)
    data.frame(tmp, stringsAsFactors = FALSE)
  } else {
    url2 <- paste(url, "/?verb=", verb, sep = "")
    tmp <- getURLContent(url2)
    tmp <- xmlParse(tmp)
  }
  tmp
}
