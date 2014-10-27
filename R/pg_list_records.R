#' List records from Pangaea
#'
#' @export
#'
#' @param prefix A character string to specify the metadata format in OAI-PMH requests issued to
#' the repository. The default (\code{"oai_dc"}) corresponds to the mandatory OAI unqualified
#' Dublin Core metadata schema.
#' @param from Character string giving datestamp to be used as lower bound for datestamp-based
#' selective harvesting (i.e., only harvest records with datestamps in the given range). Dates
#' and times must be encoded using ISO 8601. The trailing Z must be used when including time.
#' OAI-PMH implies UTC for data/time specifications.
#' @param until Character string giving a datestamp to be used as an upper bound,
#' for datestamp-based selective harvesting (i.e., only harvest records with datestamps in
#' the given range).
#' @param set A character string giving a set to be used for selective harvesting (i.e., only
#' harvest records in the given set).
#' @param ... Curl debugging options passed on to \code{\link[httr]{GET}}
#'
#' @examples \donttest{
#' res <- pg_list_records(from='2012-01-01', until='2012-01-15')
#' head(res$headers); NROW(res$headers)
#'
#' res <- pg_list_records(set='geomound', from='2012-01-01', until='2012-01-05')
#' head(res$headers); NROW(res$headers)
#'
#' # When no results found > "Error: Received condition 'noRecordsMatch'"
#' pg_list_records(set='geomound', from='2012-01-01', until='2012-01-01')
#'
#' # More examples
#' res <- pg_list_records(set='citable', from='2012-01-01', until='2012-01-05')
#' head(res$headers)
#' res$metadata[[1]]
#'
#' pg_list_records(prefix="iso19139", set='citable', from='2012-01-01', until='2012-01-05')
#' pg_list_records(prefix="dif", set='citable', from='2012-01-01', until='2012-01-05')
#' pg_list_records(prefix="dif", set='project4094', from='2012-01-01', until='2012-01-05')
#' }

pg_list_records <- function(prefix = "oai_dc", from = NULL, until = NULL, set = NULL, ...) {
  args <- pgc(list(verb="ListRecords", metadataPrefix=prefix, from=from, until=until, set=set))
  res <- pg_GET(args = args, ...)
  d <- Filter(function(x) names(x)[1] != "text", res)

  header <- lapply(d, function(z){
    tmp <- z$header
    c(tmp[ !names(tmp) %in% c('setSpec','.attrs')], setSpec=paste0(tmp[ names(tmp) %in% 'setSpec'], collapse = ","))
  })
  headerdf <- data.frame(do.call(rbind, header), stringsAsFactors = FALSE)

  if("metadata" %in% names(d[[1]])){
    metadata <- lapply(d, function(z){
      tmp <- z$metadata[[1]]
      tmp <- c(tmp[ !names(tmp) %in% 'creator'], creator=paste0(tmp[ names(tmp) %in% 'creator'], collapse = ","))
      tmp[ !names(tmp) %in% ".attrs" ]
    })
    names(metadata) <- pluck(header, "identifier", "")
  } else { metadata <- NULL }

  list(headers=headerdf, metadata=metadata)
}
