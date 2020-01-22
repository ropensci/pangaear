#' @title Caching
#'
#' @description Manage cached `pangaear` files with \pkg{hoardr}
#'
#' @export
#' @name pg_cache
#'
#' @details The dafault cache directory is
#' `paste0(rappdirs::user_cache_dir(), "/R/pangaear")`, but you can set
#' your own path using `cache_path_set()`
#'
#' `cache_delete` only accepts 1 file name, while
#' `cache_delete_all` doesn't accept any names, but deletes all files.
#' For deleting many specific files, use `cache_delete` in a [lapply()]
#' type call
#'
#' @section Useful user functions:
#'
#' - `pg_cache$cache_path_get()` get cache path
#' - `pg_cache$cache_path_set()` set cache path
#' - `pg_cache$list()` returns a character vector of full path file names
#' - `pg_cache$files()` returns file objects with metadata
#' - `pg_cache$details()` returns files with details
#' - `pg_cache$delete()` delete specific files
#' - `pg_cache$delete_all()` delete all files, returns nothing
#'
#' @examples \dontrun{
#' pg_cache
#'
#' # list files in cache
#' pg_cache$list()
#'
#' # delete certain database files
#' # pg_cache$delete("file path")
#' # pg_cache$list()
#'
#' # delete all files in cache
#' # pg_cache$delete_all()
#' # pg_cache$list()
#'
#' # set a different cache path from the default
#' # pg_cache$cache_path_set(full_path = "/Foo/Bar")
#' }
NULL
