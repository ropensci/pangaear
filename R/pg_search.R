#' Search the Pangaea database
#'
#' @export
#' @param query (character) Query terms. You can refine a search by prefixing the term(s) with a
#' category, one of citation, reference, parameter, event, project, campaign, or basis.
#' See examples.
#' @param count (integer) Number of items to return.
#' @param env (character) Type of data to search, one of "all", "sediment", "water", "ice", "atomosphere"
#' @param bbox  (numeric) A bounding box, of the form: minlon, minlat, maxlon, maxlat
#' @param mindate,maxdate (character) Dates to search for, of the form "2014-10-28"
#' @param ... Further args passed on to \code{\link[httr]{GET}}
#' @return data.frame
#' @details This is a thin wrapper around the GUI search interface on the page
#' \url{http://www.pangaea.de/}. Everything you can do there, you can do here.
#' @examples \dontrun{
#' pg_search(query='water')
#' pg_search(query='water', count=2)
#' pg_search(query='water', count=20)
#' pg_search(query='water', env="water")
#' pg_search(query='water', env="sediment")
#' pg_search(query='water', mindate="2013-06-01", maxdate="2013-07-01")
#' pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1))
#' pg_search(query='citation:Archer')
#' pg_search(query='reference:Archer')
#' pg_search(query='parameter:"carbon dioxide"')
#' pg_search(query='event:M2-track')
#' pg_search(query='event:TT011_2-CTD31')
#' pg_search(query='project:Joint Global Ocean Flux Study')
#' pg_search(query='campaign:M2')
#' pg_search(query='basis:Meteor')
#' }

pg_search <- function(query, count=10, env="all", bbox=NULL, mindate=NULL, maxdate=NULL, ...){
  args <- pgc(list(count=count, q=query, env=capwords(env), mindate=mindate, maxdate=maxdate))
  if(!is.null(bbox)) args <- c(args, as.list(setNames(bbox, c('minlon', 'minlat', 'maxlon', 'maxlat'))))
  res <- GET(sbase(), query=args, ...)
  stop_for_status(res)
  html <- content(res)
  nodes <- xpathApply(html, "//li")
  dat <- lapply(nodes, parse_res)
  do.call("rbind.data.frame", lapply(dat, data.frame, stringsAsFactors = FALSE))
}

parse_res <- function(x){
  tt <- xmlChildren(x)
  citation <- xmlValue(xmlChildren(tt$p)$a)
  tab <- readHTMLTable(tt$table, header = FALSE, trim = TRUE, stringsAsFactors=FALSE)
  tabdf <- tab[-grep("doi", tab[,1]), ]
  vals <- as.list(structure(tabdf[,2], .Names = gsub(":", "", gsub("\\s", "_", tolower(tabdf[,1])))))
  size <- as.numeric(strextract(vals$size, "[0-9]+"))
  doi <- strextract(tab[grep("doi", tab[,1]), 1], "10\\.1594/PANGAEA\\.[0-9]+")
  score <- as.numeric(sub("%", "", strextract(tab[grep("doi", tab[,1]), 1], "[0-9]+%")))
  lis <- list(doi=doi, score_per=score, size_datasets=size,
       citation=citation, supplement_to=ifn(vals$supplement_to),
       related_to=ifn(vals$related_to))
  lis[sapply(lis, length) == 0] <- NA
  lis
}

capwords <- function(s, strict = FALSE, onlyfirst = FALSE) {
  cap <- function(s) paste(toupper(substring(s,1,1)), {
    s <- substring(s,2); if(strict) tolower(s) else s
  }, sep = "", collapse = " " )
  if(!onlyfirst){
    sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
  } else {
    sapply(s, function(x)
      paste(toupper(substring(x,1,1)),
            tolower(substring(x,2)),
            sep="", collapse=" "), USE.NAMES=F)
  }
}
