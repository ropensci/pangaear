#' Identify information about the Pangaea repository
#'
#' @export
#' @importFrom OAIHarvester oaih_identify oaih_transform
#' @param transform (logical) Whether the OAI-PMH XML results to \emph{useful} R data
#' structures via \code{link{oaih_transform}}. Default: \code{TRUE}.
#'
#' @examples
#' pg_identify()

pg_identify <- function(transform = TRUE) {
  tmp <- oaih_identify(baseoai(), transform = transform)
  if (transform == TRUE) {
    tmp$description <- oaih_transform(tmp$description[[1L]])
  }
  tmp
}
