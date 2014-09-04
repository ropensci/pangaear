#' List datasets available from Pangaea
#'
#' @param transform A logical indicating whether the OAI-PMH XML results are transformed into lists of character vectors or XML nodes via oaih_transform. Default: TRUE
#'
#' @export
#' @import OAIHarvester
#'
#' @examples \donttest{
#' pg_list_sets()
#'}

pg_list_sets <- function(transform = TRUE)
{
  url <- "http://ws.pangaea.de/oai"
  tmp <- oaih_list_sets(url, transform = transform)
  data.frame(tmp, stringsAsFactors = FALSE)
}
