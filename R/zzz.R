baseoai <- function() "http://ws.pangaea.de/oai/"
base <- function() 'http://doi.pangaea.de/'
sbase <- function() "http://www.pangaea.de/search"

pgc <- function (l) Filter(Negate(is.null), l)

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}

check <- function(x){
  if(is.character(x)){
    if( grepl("does not exist|unknown", x))
      stop(x, call. = FALSE)
  }
}

read_csv <- function(x){
  lns <- readLines(x, n = 300)
  ln_no <- grep("\\*/", lns)
  tmp <- read.csv(x, header = FALSE, sep = "\t", skip = ln_no+1, stringsAsFactors=FALSE)
  nn <- strsplit(lns[ln_no+1], "\t")[[1]]
  setNames(tmp, nn)
}

ifn <- function(x) if(is.null(x)) NA else x

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))
