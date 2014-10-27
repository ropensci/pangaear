#' List the set structure of the Pangaea repository
#'
#' @export
#' @importFrom OAIHarvester oaih_list_sets
#' @importFrom XML xmlParse
#' @param ... Curl debugging options passed on to \code{\link[httr]{GET}}
#'
#' @examples \donttest{
#' head( pg_list_sets() )
#' library('httr')
#' res <- pg_list_sets(verbose())
#' }

pg_list_sets <- function(...) {
  res <- pg_GET(args = pgc(list(verb="ListSets")), ...)
  data.frame(do.call(rbind, res), stringsAsFactors = FALSE)
}
#   if (transform) {
#     tmp <- oaih_list_sets(baseoai(), transform = transform)
#     data.frame(tmp, stringsAsFactors = FALSE)
#   } else {
#     url2 <- paste(baseoai(), "/?verb=", "ListSets", sep = "")
#     tmp <- GET(url2)
#     tmp <- xmlParse(tmp)
#   }
#   tmp
