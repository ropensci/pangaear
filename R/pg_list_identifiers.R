#' List identifiers of the Pangaea repository
#'
#' @export
#' @importFrom httr GET content stop_for_status
#' @inheritParams pg_list_records
#'
#' @examples \donttest{
#' pg_list_identifiers(from='2012-01-01', until='2012-01-05')
#' pg_list_identifiers(from='2013-10-01', until='2013-10-05')
#' pg_list_identifiers(from='2013-10-01', until='2013-10-03', set="geocode1")
#' pg_list_identifiers(prefix="iso19139", from='2012-01-01', until='2012-01-05')
#' pg_list_identifiers(prefix="dif", from='2012-01-01', until='2012-01-05')
#'
#' library('httr')
#' pg_list_identifiers(prefix="dif", from='2012-01-01', until='2012-01-05', config=verbose())
#' }

pg_list_identifiers <- function(prefix = "oai_dc", from = NULL, until = NULL, set = NULL, ...)
{
  args <- pgc(list(verb="ListIdentifiers", metadataPrefix=prefix, from=from, until=until, set=set))
  res <- pg_GET(args = args, ...)
  done <- lapply(res, function(x){
    c(x[1:2], setSpec=paste0(unlist(x[names(x) %in% "setSpec"]), collapse = ","))
  })
  data.frame(do.call(rbind, done), stringsAsFactors = FALSE)
}
