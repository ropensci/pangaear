#' Get record from the Pangaea repository
#'
#' @export
#' @importFrom OAIHarvester oaih_get_record
#' @param identifier Dataset identifier. See Examples.
#' @param transform (logical) Transform the output to XML via \code{\link[XML]{xmlParse}}
#'
#' @examples \donttest{
#' record <- pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#' record$identifier
#' record$metadata
#'
#' record <- pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.269656",
#' prefix="iso19139")
#' record$identifier
#' }

pg_get_record <- function(identifier, prefix = "oai_dc", transform = TRUE){
  oaih_get_record(baseoai(), identifier = identifier, prefix = prefix, transform = transform)
}
