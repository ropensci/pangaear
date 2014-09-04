#' List records from Pangaea
#'
#' @export
#' @importFrom OAIHarvester oaih_list_records
#'
#' @param prefix A character string to specify the metadata format in OAI-PMH requests issued to
#' the repository. The default ("oai_dc") corresponds to the mandatory OAI unqualified Dublin Core
#' metadata schema.
#' @param from Character strings giving datestamps to be used as lower or upper bounds,
#' respectively, for datestamp-based selective harvesting (i.e., only harvest records with
#' datestamps in the given range). Dates and times must be encoded using ISO 8601. The trailing
#' Z must be used when including time. OAI-PMH implies UTC for data/time specifications.
#' @param until Character string giving a datestamp to be used as an upper bound,
#' for datestamp-based selective harvesting (i.e., only harvest records with datestamps in
#' the given range).
#' @param set A character string giving a set to be used for selective harvesting (i.e., only
#' harvest records in the given set).
#' @param transform A logical indicating whether the OAI-PMH XML results to “useful” R data
#' structures via oaih_transform. Default: true.
#'
#' @examples \dontrun{
#' res <- pg_list_records(from='2012-01-01', until='2012-01-15')
#' head(res)
#'
#' res <- pg_list_records(set='geomound', from='2012-01-01', until='2012-01-05')
#' head(res); NROW(res)
#'
#' # When no results found > "Error: Received condition 'noRecordsMatch'"
#' pg_list_records(set='geomound', from='2012-01-01', until='2012-01-01')
#' }

pg_list_records <- function(prefix = "oai_dc", from = NULL, until = NULL, set = NULL, transform = TRUE)
{
  url <- "http://ws.pangaea.de/oai"
  tmp <- oaih_list_records(url, prefix = prefix, from = from, until = until, set = set, transform = transform)
  data.frame(tmp, stringsAsFactors = FALSE)
}
