#' Functions to download data from Pangaea.
#'
#' Grabs data as a dataframe or list of dataframes from a Pangaea data repository URI; see: \url{http://www.pangaea.de/}. Expects the individual data files to be in tab-delimited text format
#'
#' @author Naupaka Zimmerman
#' @import RCurl devtools
#' @export
#' @param uri Public internet address of the data
#' @return dataframe with rows of data, list of dataframes with rows of data if there are multiple related data sets found at the URI
#' @examples \donttest{
#' .get_data_from_uri("http://api.example.com/ecologydata")
#' }

.get_data_from_uri <- function(uri){
    uri <- paste0(uri,"?format=textfile")
    response <- RCurl::getURLContent(uri)
    raw_data <- gsub("/\\*.*\\*/\n", "", response)
    df <- read.delim(textConnection(raw_data))
    df
}

.get_multiple_data_from_uri <- function(uri){

  response <- RCurl::getURLContent(uri)
  if(grepl("name=\"dslist\"", response) == TRUE){
    data_file_dois <- gregexpr("<div class=\"MetaHeaderItem\"><a rel=\"follow\" href=\"(http://doi.pangaea.de/.*?)\">", response)
    data_file_dois <- regmatches(response, data_file_dois)
    data_file_dois <- unlist(data_file_dois)
    split_doi <- strsplit(data_file_dois, split = "\"")
    doi_vector <- sapply(split_doi, function (x) x[grepl("doi",x)])
    out.temp <- lapply(doi_vector[1:2], .get_data_from_uri)
  }
  else{
    raw_data <- gsub("/\\*.*\\*/\n", "", response)
    df <- read.delim(textConnection(raw_data))
    df
  }
}

# testing
# uri <- "http://doi.pangaea.de/10.1594/PANGAEA.820036?format=textfile" #single
# uri <- "http://doi.pangaea.de/10.1594/PANGAEA.807575?format=textfile" #single
# uri <- "http://doi.pangaea.de/10.1594/PANGAEA.807587" #many
# uri <- "http://doi.pangaea.de/10.1594/PANGAEA.807575"
