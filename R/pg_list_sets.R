#' List the set structure of the Pangaea repository
#'
#' @export
#' @importFrom OAIHarvester oaih_list_sets
#' @param transform logical; whether the OAI-PMH XML results to \emph{useful} R data
#' structures via \code{link{oaih_transform}}. Default: \code{TRUE}.
#'
#' @examples \donttest{
#' pg_list_sets()
#' }

pg_list_sets <- function(transform = TRUE) {
  url <- "http://ws.pangaea.de/oai"
  tmp <- oaih_list_sets(url, transform = transform)
  data.frame(tmp, stringsAsFactors = FALSE)
}

