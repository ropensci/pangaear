#' List identifiers of the Pangaea repository
#'
#' @export
#' @inheritParams pg_list_records
#' @param token	(character) a token previously provided by the server to
#' resume a request where it last left off. 50 is max number of records
#' returned. We will loop for you internally to get all the records you
#' asked for.
#' @param as (character) What to return. One of "df" (for data.frame; default),
#' "list", or "raw" (raw text)
#' @param ... Curl debugging options passed on to [oai::list_identifiers()]
#' @return XML character string, data.frame, or list, depending on what
#' requested with the `as` parameter
#' @references [OAI-PMH documentation](https://www.openarchives.org/pmh/)
#' @seealso wraps [oai::list_identifiers()]
#' @family oai methods
#' @examples \dontrun{
#' pg_list_identifiers(
#'   from = paste0(Sys.Date() - 2, "T00:00:00Z"),
#'   until = paste0(Sys.Date() - 1, "T18:00:00Z")
#' )
#' pg_list_identifiers(set="geocode1", from=Sys.Date()-1, until=Sys.Date())
#' pg_list_identifiers(prefix="iso19139", from=Sys.Date()-1, until=Sys.Date())
#' pg_list_identifiers(prefix="dif",
#'   from = paste0(Sys.Date() - 2, "T00:00:00Z"),
#'   until = paste0(Sys.Date() - 1, "T18:00:00Z")
#' )
#' }

pg_list_identifiers <- function(prefix = "oai_dc", from = NULL, until = NULL,
                                set = NULL, token = NULL, as = "df", ...) {

  oai::list_identifiers(url = baseoai(), prefix = prefix, from = from,
                        until = until, set = set, token = token, as = as, ...)
}
