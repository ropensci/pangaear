#' Client for the Pangaea Database
#'
#' [Pangaea database](https://www.pangaea.de/)
#'
#' Package includes tools to interact with the Pangaea Database,
#' including functions for searching for data, fetching datasets by
#' dataset ID, working with the Pangaea OAI-PMH service, and
#' Elasticsearch service.
#' 
#' @section Getting data:
#' The main workhorse function for getting data is [pg_data()]. 
#' One thing you may want to do is set a different path for caching 
#' the data you download: see [pg_cache] for details
#'
#' @importFrom oai list_identifiers get_records list_sets list_metadataformats
#' list_identifiers id
#' @importFrom crul HttpClient
#' @importFrom xml2 read_html xml_find_all xml_attr xml_text xml_find_first
#' xml_parent
#' @importFrom tibble as_tibble
#' @importFrom hoardr hoard
#' @name pangaear-package
#' @aliases pangaear
#' @docType package
NULL
