#' Function to download data from Pangaea
#'
#' This function allows you to download a zip file of data from the Pangaea data repository http://www.pangaea.de/
#' @import RCurl devtools
#' @param
#' @keywords
#' @export
#' @examples
#' pangaea_download()

library("devtools")
library("RCurl")

#' .get_data_from_uri
#'
#' Grabs data as dataframe from a URI. Expects the response data to be in JSON format
#'
#' @param uri Public internet address of the data
#' @return dataframe with rows of data
#' @examples \dontrun{
#' .get_data_from_uri("http://api.example.com/ecologydata")
#' }

# testing
# uri <- "http://doi.pangaea.de/10.1594/PANGAEA.820036?format=textfile"
# uri <- "http://doi.pangaea.de/10.1594/PANGAEA.807575?format=textfile"

.get_data_from_uri<-function(uri){

    response <- RCurl::getURLContent(uri)
    raw_data <- gsub("/\\*.*\\*/\n", "", response)
    df <- read.delim(textConnection(raw_data))
    df

}
