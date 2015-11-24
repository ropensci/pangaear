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

pg_GET <- function(args, unname=TRUE, ...){
  res <- GET(baseoai(), query=args, ...)
  stop_for_status(res)
  tt <- content(res, "text")
  xml <- xmlParse(tt)
  kids <- xmlChildren(xmlRoot(xml)[[3L]])
  token <- kids$resumptionToken
  if (unname) lapply(unname(kids), function(z) xmlToList(z)) else kids
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
#   ln_no <- grep("\\*/", iconv(lns, from = "ISO-8859-1", to = "UTF-8"))
  tmp <- read.csv(x, header = FALSE, sep = "\t", skip = ln_no+1, stringsAsFactors=FALSE)
  nn <- strsplit(lns[ln_no+1], "\t")[[1]]
# nn <- strsplit(iconv(lns[ln_no+1], from = "ISO-8859-1", to = "UTF-8"), "\t")[[1]]
  names(tmp) <- nn
#   names(tmp) <- tolower(gsub("\\.", "_", gsub("\\.\\.", "_", gsub("\\.+$", "", names(tmp)))))
  tmp
}

ifn <- function(x) if(is.null(x)) NA else x

# ff <- file(x, open = "r", encoding = "UTF-8")
# read.table(ff, header = TRUE, sep = "\t", stringsAsFactors=FALSE)

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))
