#' Get metadata formats from the Pangaea repository
#'
#' @export
#' @importFrom OAIHarvester oaih_list_metadata_formats
#'
#' @examples
#' pg_list_metadata_formats()

pg_list_metadata_formats <- function(){
  formats <- oaih_list_metadata_formats(baseoai())
  data.frame(formats)
}
