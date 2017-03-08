#' Client for the Pangaea Database
#'
#' [Pangaea database](https://www.pangaea.de/)
#'
#' Package includes tools to interact with the Pangaea Database,
#' including functions for searching for data, fetching datasets by
#' dataset ID, working with the Pangaea OAI-PMH service, and
#' Elasticsearch service.
#'
#' @importFrom oai list_identifiers get_records list_sets list_metadataformats
#' list_identifiers id
#' @importFrom httr GET content stop_for_status write_disk config
#' @importFrom xml2 read_html xml_find_all xml_attr xml_text xml_find_first
#' xml_parent
#' @importFrom tibble as_data_frame
#' @importFrom rappdirs user_cache_dir
#' @name pangaear-package
#' @aliases pangaear
#' @docType package
NULL
