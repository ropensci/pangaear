#' Get record from the Pangaea repository
#'
#' @export
#' @param identifier Dataset identifier. See Examples.
#' @param prefix A character string to specify the metadata format in OAI-PMH
#' requests issued to the repository. The default (`oai_dc`) corresponds
#' to the mandatory OAI unqualified Dublin Core metadata schema.
#' @param as (character) What to return. One of "df" (for data.frame; default),
#' "list", or "raw" (raw text)
#' @param ... Curl debugging options passed on to [oai::get_records()]
#' @return XML character string, data.frame, or list, depending on what
#' requested with the `as` parameter
#' @references [OAI-PMH documentation](https://www.openarchives.org/pmh/)
#' @seealso wraps [oai::get_records()]
#' @family oai methods
#' @examples \dontrun{
#' pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#' pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.269656",
#' prefix="iso19139")
#' pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.269656",
#' prefix="dif")
#'
#' # invalid record id
#' # pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.11111")
#' # pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.11111",
#' #   prefix="adfadf")
#' }
pg_get_record <- function(identifier, prefix = "oai_dc", as = "df", ...){
  oai::get_records(ids = identifier, prefix = prefix, url = baseoai(),
                   as = as, ...)
}
