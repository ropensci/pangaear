baseoai <- function() "http://ws.pangaea.de/oai/"

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
