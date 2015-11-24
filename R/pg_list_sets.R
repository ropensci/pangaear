#' List the set structure of the Pangaea repository
#'
#' @export
#' @importFrom XML xmlParse xmlChildren xmlRoot xmlValue xmlToList
#' @param ... Curl debugging options passed on to \code{\link[httr]{GET}}
#'
#' @examples \donttest{
#' head( pg_list_sets() )
#' library('httr')
#' res <- pg_list_sets(config = verbose())
#' }

pg_list_sets <- function(...) {
  res <- pg_GET(args = pgc(list(verb = "ListSets")), ...)
  data.frame(do.call(rbind, res), stringsAsFactors = FALSE)
}
