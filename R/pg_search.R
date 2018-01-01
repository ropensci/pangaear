#' Search the Pangaea database
#'
#' @export
#' @param query (character) Query terms. You can refine a search by prefixing
#' the term(s) with a category, one of citation, reference, parameter, event,
#' project, campaign, or basis. See examples.
#' @param topic (character) topic area: one of NULL (all areas), "Agriculture",
#' "Atomosphere", "Biological Classification", "Biospshere", "Chemistry",
#' "Cryosphere", "Ecology", "Fisheries", "Geophysics", "Human Dimensions",
#' "Lakes & Rivers", "Land Surface", "Lithosphere", "Oceans", "Paleontology"
#' @param count (integer) Number of items to return. Default: 10. Maximum: 500.
#' Use `offset` parameter to page through results - see examples
#' @param offset (integer) Record number to start at. Default: 0
#' @param bbox  (numeric) A bounding box, of the form: minlon, minlat, maxlon,
#' maxlat
#' @param mindate,maxdate (character) Dates to search for, of the form
#' "2014-10-28"
#' @param ... Curl options passed on to [crul::HttpClient()]
#' @return tibble/data.frame with the structure:
#' \itemize{
#'  \item score - match score, higher is a better match
#'  \item doi - the DOI for the data package
#'  \item size - size number
#'  \item size_measure - size measure, one of "data points" or "datasets"
#'  \item citation - citation for the data package
#'  \item supplement_to - citation for what the data package is a
#'  supplement to
#' }
#' @details This is a thin wrapper around the GUI search interface on the page
#' <https://www.pangaea.de>. Everything you can do there, you can do here.
#' @seealso [pg_search_es()]
#' @examples \dontrun{
#' pg_search(query='water')
#' pg_search(query='water', count=2)
#' pg_search(query='water', count=20)
#' pg_search(query='water', mindate="2013-06-01", maxdate="2013-07-01")
#' pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1))
#' pg_search(query='reference:Archer')
#' pg_search(query='parameter:"carbon dioxide"')
#' pg_search(query='event:M2-track')
#' pg_search(query='event:TT011_2-CTD31')
#' pg_search(query='project:Joint Global Ocean Flux Study')
#' pg_search(query='campaign:M2')
#' pg_search(query='basis:Meteor')
#'
#' # paging with count and offset
#' # max is 500 records per request - if you need > 500, use offset and count
#' res1 <- pg_search(query = "florisphaera", count = 500, offset = 0)
#' res2 <- pg_search(query = "florisphaera", count = 500, offset = 500)
#' res3 <- pg_search(query = "florisphaera", count = 500, offset = 1000)
#' do.call("rbind.data.frame", list(res1, res2, res3))
#'
#' # get attributes: maxScore, totalCount, and offset
#' res <- pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1))
#' attributes(res)
#' attr(res, "maxScore")
#' attr(res, "totalCount")
#' attr(res, "offset")
#'
#' # curl options
#' pg_search(query='citation:Archer', verbose = TRUE)
#' }

pg_search <- function(query, count = 10, offset = 0, topic = NULL, bbox = NULL,
                      mindate = NULL, maxdate = NULL, ...) {
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- "env" %in% calls
  if (any(calls_vec)) {
    stop("'env' has been removed, use topic instead and see ?pg_search",
         call. = FALSE)
  }

  check_if(count, c("numeric", "integer"))
  check_if(topic, "character")
  check_if(mindate, "character")
  check_if(maxdate, "character")
  args <- pgc(list(t = topic, count = count, offset = offset, q = query,
                   mindate = mindate, maxdate = maxdate))
  if (!is.null(bbox)) args <- c(
    args, as.list(stats::setNames(bbox,
                                  c('minlon', 'minlat', 'maxlon', 'maxlat'))))
  
  cli <- crul::HttpClient$new(url = sbase())
  res <- cli$get(query = args, ...)
  res$raise_for_status()
  results <- jsonlite::fromJSON(res$parse("UTF-8"), FALSE)
  parsed <- lapply(results$results, function(x) {
    x <- utils::modifyList(x, list(doi = gsub("doi:", "", x$URI)))
    xx <- parse_res(x)
    x$URI <- x$html <- NULL
    c(x, xx)
  })
  df <- do.call("rbind.data.frame", lapply(parsed, tibble::as_data_frame))
  atts <- results[c('maxScore', 'offset', 'totalCount')]
  for (i in seq_along(atts)) {
    attr(df, names(atts)[i]) <- atts[[i]]
  }
  return(df)
}

parse_res <- function(x) {
  html <- xml2::read_html(x$html)
  citation <- xml_text(xml_find_all(html, './/div[@class="citation"]/a'))
  tab <- xml_find_all(html, './/table/tr')
  supp <- xml_text(
    xml_find_first(
      xml_parent(
        xml_find_all(
          tab, ".//td[contains(.,'Supplement')]")), './/td[@class="content"]'))
  size <- strextract(
    xml_text(
      xml_find_all(
        xml_parent(
          xml_find_all(
            tab,
            ".//td[contains(.,'Size')]")),
        './/td[@class="content"]')), ".+")
  size_val <- strextract(size, "[0-9]+")
  size_val2 <- tryCatch(as.numeric(size_val), warning = function(w) w)
  size_val <- if (inherits(size_val2, "warning"))  size_val else size_val2
  meas <- strextract(size, "[A-Za-z].+")
  lis <- list(
    size = size_val,
    size_measure = meas,
    citation = citation,
    supplement_to = supp
  )
  lis[vapply(lis, length, 1) == 0] <- NA
  lis
}

check_if <- function(x, cls) {
  if (!is.null(x)) {
    if (!class(x) %in% cls) {
      stop(substitute(x), " must be of class: ", paste0(cls, collapse = ", "),
           call. = FALSE)
    }
  }
}
