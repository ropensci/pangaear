#' Get record from the Pangaea repository
#'
#' @export
#' @param identifier Dataset identifier. See Examples.
#' @param prefix A character string to specify the metadata format in OAI-PMH requests issued to
#' the repository. The default (\code{"oai_dc"}) corresponds to the mandatory OAI unqualified
#' Dublin Core metadata schema.
#' @param ... Curl debugging options passed on to \code{\link[httr]{GET}}
#'
#' @examples \donttest{
#' record <- pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#' record$header
#' record$metadata
#'
#' record <- pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.269656",
#' prefix="iso19139")
#' record$header
#' record$metadata
#'
#' record <- pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.269656",
#' prefix="dif")
#' record$header
#' record$metadata
#'
#' # curl options
#' library('httr')
#' pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382", config=verbose())
#'
#' # invalid record id
#' pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.11111")
#' pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.11111", prefix="adfadf")
#' }

pg_get_record <- function(identifier, prefix = "oai_dc", ...){
  res <- pg_GET(args = list(verb="GetRecord", identifier=identifier, metadataPrefix=prefix), ...)
  check(res[[1]])
  list(header=res[[1]]$header, metadata=res[[1]]$metadata)
}
