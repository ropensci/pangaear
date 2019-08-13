#' cache path clear
#' @export
#' @rdname pg_cache_clear-defunct
#' @param ... ignored
pg_cache_clear <- function(...) {
  .Defunct(msg = "defunct, see pg_cache$delete() and pg_cache$delete_all()")
}

#' cache list 
#' @export
#' @rdname pg_cache_list-defunct
#' @param ... ignored
pg_cache_list <- function(...) .Defunct(msg = "defunct, see pg_cache$list()")
