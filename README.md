pangaear
========



[![cran checks](https://cranchecks.info/badges/worst/pangaear)](https://cranchecks.info/pkgs/pangaear)
[![R-check](https://github.com/ropensci/pangaear/workflows/R-check/badge.svg)](https://github.com/ropensci/pangaear/actions?query=workflow%3AR-check)
[![codecov](https://codecov.io/gh/ropensci/pangaear/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/pangaear)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/pangaear)](https://github.com/r-hub/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/pangaear)](https://cran.r-project.org/package=pangaear)

`pangaear` is a data retrieval interface for the World Data Center PANGAEA (https://www.pangaea.de/). PANGAEA archieves published Earth & Environmental Science data under the following subjects: agriculture, atmosphere, biological classification, biosphere, chemistry, cryosphere, ecology, fisheries, geophysics, human dimensions, lakes & rives, land surface, lithosphere, oceans, and paleontology.

This package offers tools to interact with the PANGAEA Database, including functions for searching for data, fetching datasets by dataset ID, and working with the PANGAEA OAI-PMH service.

## Info

* Pangaea [website](https://www.pangaea.de/).
* Pangaea [OAI-PMH docs](https://wiki.pangaea.de/wiki/OAI-PMH).
* [OAI-PMH Spec](http://www.openarchives.org/OAI/openarchivesprotocol.html)

## Package API

 - pg_data
 - pg_list_metadata_formats
 - pg_identify
 - pg_list_records
 - pg_list_sets
 - pg_list_identifiers
 - pg_search
 - pg_get_record
 - pg_cache
 - pg_search_es
 - pg_cache_list
 - pg_cache_clear

## Installation

Stable version


```r
install.packages("pangaear")
```

Dev version


```r
remotes::install_github('ropensci/pangaear')
```


```r
library('pangaear')
```

## Search for data

This is a thin wrapper around the GUI search interface on the page <https://www.pangaea.de/>. Everything you can do there, you can do here.


```r
pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
#> # A tibble: 3 x 6
#>   score doi       size size_measure citation             supplement_to          
#>   <dbl> <chr>    <dbl> <chr>        <chr>                <chr>                  
#> 1 13.3  10.1594…     4 datasets     Krylova, EM; Sahlin… Krylova, EM; Sahling, …
#> 2 13.1  10.1594…     2 datasets     Simonyan, AV; Dultz… Simonyan, AV; Dultz, S…
#> 3  8.93 10.1594…   598 data points  WOCE Surface Veloci… <NA>
```

## Get data


```r
res <- pg_data(doi = '10.1594/PANGAEA.807580')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.807580
#>   parent doi: 10.1594/PANGAEA.807580
#>   url:        https://doi.org/10.1594/PANGAEA.807580
#>   citation:   Schiebel, Ralf; Waniek, Joanna J; Bork, Matthias; Hemleben, Christoph (2001): Physical oceanography during METEOR cruise M36/6. PANGAEA, https://doi.org/10.1594/PANGAEA.807580, In supplement to: Schiebel, R et al. (2001): Planktic foraminiferal production stimulated by chlorophyll redistribution and entrainment of nutrients. Deep Sea Research Part I: Oceanographic Research Papers, 48(3), 721-740, https://doi.org/10.1016/S0967-0637(00)00065-0
#>   path:       /Users/sckott/Library/Caches/R/pangaear/10_1594_PANGAEA_807580.txt
#>   data:
#> # A tibble: 32,179 x 13
#>    Event       `Date/Time`   Latitude Longitude `Elevation [m]` `Depth water [m…
#>    <chr>       <chr>            <dbl>     <dbl>           <int>            <dbl>
#>  1 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             0   
#>  2 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             0.99
#>  3 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             1.98
#>  4 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             2.97
#>  5 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             3.96
#>  6 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             4.96
#>  7 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             5.95
#>  8 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             6.94
#>  9 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             7.93
#> 10 M36/6-CTD-… 1996-10-14T1…     49.0     -16.5           -4802             8.92
#> # … with 32,169 more rows, and 7 more variables: Press [dbar] <int>,
#> #   Temp [°C] <dbl>, Sal <dbl>, Tpot [°C] <dbl>, Sigma-theta [kg/m**3] <dbl>,
#> #   Sigma in situ [kg/m**3] <dbl>, Cond [mS/cm] <dbl>
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.406110
#>   parent doi: 10.1594/PANGAEA.406110
#>   url:        https://doi.org/10.1594/PANGAEA.406110
#>   citation:   WOCE Surface Velocity Program, SVP (2006): Water temperature and current velocity from surface drifter SVP_9616641. PANGAEA, https://doi.org/10.1594/PANGAEA.406110
#>   path:       /Users/sckott/Library/Caches/R/pangaear/10_1594_PANGAEA_406110.txt
#>   data:
#> # A tibble: 101 x 10
#>    `Date/Time`  Latitude Longitude `Depth water [m… `Temp [°C]` `Cur vel U [cm/…
#>    <chr>           <dbl>     <dbl>            <int>       <dbl>            <dbl>
#>  1 1996-11-11T…     41.6     -125.                0        12.7            NA   
#>  2 1996-11-11T…     41.6     -125.                0        12.5            11.3 
#>  3 1996-11-12T…     41.6     -124.                0        12.4             2.91
#>  4 1996-11-12T…     41.7     -124.                0        12.3             3.64
#>  5 1996-11-12T…     41.7     -124.                0        11.9            23.4 
#>  6 1996-11-12T…     41.7     -124.                0        11.4            21.4 
#>  7 1996-11-13T…     41.8     -124.                0        11.1             0.21
#>  8 1996-11-13T…     41.8     -124.                0        11.2            -0.86
#>  9 1996-11-13T…     41.8     -124.                0        11.1             1.51
#> 10 1996-11-13T…     41.9     -124.                0        11.0            -5.58
#> # … with 91 more rows, and 4 more variables: Cur vel V [cm/s] <dbl>,
#> #   Latitude e <dbl>, Longitude e <dbl>, Code <int>
#> 
#> [[2]]
#> NULL
#> 
#> [[3]]
#> NULL
```

## OAI-PMH metadata


```r
# Identify the service
pg_identify()

# List metadata formats
pg_list_metadata_formats()

# List identifiers
pg_list_identifiers(from = Sys.Date() - 2, until = Sys.Date())

# List sets
pg_list_sets()

# List records
pg_list_records(from = Sys.Date() - 1, until = Sys.Date())

# Get a record
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
```

## Contributors (reverse alphabetical)

* Naupaka Zimmerman
* Kara Woo
* Gavin Simpson
* Andrew MacDonald
* Scott Chamberlain

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/pangaear/issues).
* License: MIT
* Get citation information for `pangaear` in R doing `citation(package = 'pangaear')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.
