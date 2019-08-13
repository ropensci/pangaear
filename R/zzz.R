baseoai <- function() "https://ws.pangaea.de/oai/provider"
base <- function() 'https://doi.pangaea.de/'
sbase <- function() "https://www.pangaea.de/advanced/search.php"
esbase <- function() "https://ws.pangaea.de/es/pangaea/panmd/_search"

pgc <- function(x) Filter(Negate(is.null), x)

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}

check <- function(x) {
  if (is.character(x)) {
    if ( grepl("does not exist|unknown", x))
      stop(x, call. = FALSE)
  }
}

read_csv <- function(x) {
  lns <- readLines(x, n = 1000)
  ln_no <- grep("\\*/", lns)
  tmp <- utils::read.csv(x, header = FALSE, sep = "\t",
                  skip = ln_no + 1, stringsAsFactors = FALSE)
  nn <- strsplit(lns[ln_no + 1], "\t")[[1]]
  stats::setNames(tmp, nn)
}

read_meta <- function(x) {
  # return NA if not a .txt file
  if (!grepl("\\.txt", x)) return(list())

  lns <- readLines(x, n = 1000)
  ln_no <- grep("\\*/", lns)
  all_lns <- seq_len(ln_no)
  txt <- lns[all_lns[-c(1, length(all_lns))]]
  starts <- grep(":\\\t", txt)
  ext <- list()
  for (i in seq_along(starts)) {
    end <- starts[i + 1] - 1
    if (is.na(end)) {
      gt <- starts[i]
    } else {
      gt <- if (starts[i] == end) {
        starts[i]
      } else {
        starts[i]:end
      }
    }
    ext[[i]] <- txt[gt]
  }
  ext2 <- list()
  for (i in seq_along(ext)) {
    sp <- strsplit(ext[[i]], "\\\t")
    nm <- tolower(gsub("\\s", "_", gsub(":|\\(|\\)", "", sp[[1]][1])))
    if (length(sp) > 1) {
      tmp <- unlist(c(sp[[1]][-1], sp[-1]))
      tmp <- tmp[nzchar(tmp)]
      dat <- paste0(tmp, collapse = "; ")
    } else {
      dat <- sp[[1]][-1]
      if (nm == "events") {
        dat <- sapply(strsplit(dat, "\\s\\*\\s")[[1]], function(z) {
          zz <- strsplit(z, ":\\s")[[1]]
          zz <- gsub("^\\s|\\s$", "", zz)
          as.list(stats::setNames(zz[2], zz[1]))
        }, USE.NAMES = FALSE)
        dat <- list(dat)
      }
    }
    ext2[[i]] <- as.list(stats::setNames(dat, nm))
  }
  ext2 <- unlist(ext2, FALSE)
  # attempt to handle parameters
  if ("parameters" %in% names(ext2)) {
    parm <- ext2$parameters
    parm <- strw(strsplit(parm, ";")[[1]])
    ext2$parameters <- lapply(parm, function(w) {
      strw(strsplit(w, "\\*")[[1]])
    })
  }
  return(ext2)
}

strw <- function(x) gsub("^\\s|\\s$", "", x)

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

cl <- function(x) if (is.null(x)) NULL else paste0(x, collapse = ",")

cn <- function(x) {
  name <- substitute(x)
  if (!is.null(x)) {
    tryx <- tryCatch(as.numeric(as.character(x)), warning = function(e) e)
    if ("warning" %in% class(tryx)) {
      stop(name, " should be a numeric or integer class value", call. = FALSE)
    }
    if (!is.numeric(tryx) | is.na(tryx))
      stop(name, " should be a numeric or integer class value", call. = FALSE)
    return( format(x, digits = 22, scientific = FALSE) )
  } else {
    NULL
  }
}

as_log <- function(x) {
  if (is.null(x)) {
    x
  } else {
    if (x) 'true' else 'false'
  }
}
