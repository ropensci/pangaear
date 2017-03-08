pangaear
========



[![Build Status](https://travis-ci.org/ropensci/pangaear.svg?branch=master)](https://travis-ci.org/ropensci/pangaear)
[![Build status](https://ci.appveyor.com/api/projects/status/564oioj2oyefax08?svg=true)](https://ci.appveyor.com/project/sckott/pangaear)
[![codecov](https://codecov.io/gh/ropensci/pangaear/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/pangaear)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/pangaear)](https://github.com/metacran/cranlogs.app)
[![cran version](https://www.r-pkg.org/badges/version/pangaear)](https://cran.r-project.org/package=pangaear)

An R client to interact with the [Pangaea database](https://www.pangaea.de/).

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
install.packages("devtools")
devtools::install_github('ropensci/pangaear')
```


```r
library('pangaear')
```

## Search for data

This is a thin wrapper around the GUI search interface on the page [http://www.pangaea.de/](http://www.pangaea.de/). Everything you can do there, you can do here.


```r
pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
#> # A tibble: 3 × 6
#>      score                    doi  size size_measure
#> *    <dbl>                  <chr> <dbl>        <chr>
#> 1 21.58509 10.1594/PANGAEA.812094     2     datasets
#> 2 11.01751 10.1594/PANGAEA.862525   372     datasets
#> 3 10.91036 10.1594/PANGAEA.736010     9     datasets
#> # ... with 2 more variables: citation <chr>, supplement_to <chr>
```

## Get data


```r
res <- pg_data(doi = '10.1594/PANGAEA.807580')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.807580
#> # A tibble: 32,179 × 13
#>                Event      `Date/Time` Latitude Longitude `Elevation [m]`
#>                <chr>            <chr>    <dbl>     <dbl>           <int>
#> 1  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 2  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 3  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 4  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 5  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 6  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 7  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 8  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 9  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> 10 M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633           -4802
#> # ... with 32,169 more rows, and 8 more variables: `Depth water
#> #   [m]` <dbl>, `Press [dbar]` <int>, `Temp [°C]` <dbl>, Sal <dbl>, `Tpot
#> #   [°C]` <dbl>, `Sigma-theta [kg/m**3]` <dbl>, `Sigma in situ
#> #   [kg/m**3]` <dbl>, `Cond [mS/cm]` <dbl>
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.77406
#> # A tibble: 1 × 4
#>   `Depth [m]` `SOD [mmol/m**2/day]` `SOD [mmol/m**2/day]` `O2 [µmol/l]`
#>         <int>                 <dbl>                 <dbl>         <dbl>
#> 1           0                  1.51                  0.74            25
#>
#> [[2]]
#> <Pangaea data> 10.1594/PANGAEA.77397
#> # A tibble: 27 × 6
#>    `Depth [m]` `O2 [µmol/l]` `Poros frac` `Mn [µmol/l]` `Fe [µmol/l]`
#>          <dbl>         <dbl>        <dbl>         <dbl>         <dbl>
#> 1       -0.010          97.7          1.0            NA            NA
#> 2       -0.005          96.2          1.0            NA            NA
#> 3       -0.001          93.2          1.0            NA            NA
#> 4        0.000          61.3          0.9            NA            NA
#> 5        0.001          35.8          0.9            NA            NA
#> 6        0.002          19.0          0.9           1.9            NA
#> 7        0.003           5.4          0.9           4.0           2.2
#> 8        0.004           0.1          0.8            NA            NA
#> 9        0.005           0.0          0.8            NA            NA
#> 10       0.006           0.4          0.7            NA            NA
#> # ... with 17 more rows, and 1 more variables: `TOC [%]` <dbl>
#>
#> [[3]]
#> <Pangaea data> 10.1594/PANGAEA.77398
#> # A tibble: 27 × 6
#>    `Depth [m]` `O2 [µmol/l]` `Poros frac` `Mn [µmol/l]` `Fe [µmol/l]`
#>          <dbl>         <dbl>        <dbl>         <dbl>         <dbl>
#> 1      -0.0100          91.8          1.0            NA            NA
#> 2      -0.0050          85.6          1.0            NA            NA
#> 3      -0.0010          80.5          1.0            NA            NA
#> 4       0.0000          45.2          1.0            NA            NA
#> 5       0.0005          33.7           NA            NA            NA
#> 6       0.0010          20.7          0.9            NA            NA
#> 7       0.0015           6.6           NA            NA            NA
#> 8       0.0020           2.4          0.8           0.5            NA
#> 9       0.0030           1.8          0.7           3.8            NA
#> 10      0.0040           1.7          0.7            NA           5.9
#> # ... with 17 more rows, and 1 more variables: `TOC [%]` <dbl>
```

## OAI-PMH metadata

### Identify the service


```r
pg_identify()
#> <Pangaea>
#>   repositoryName: PANGAEA - Data Publisher for Earth & Environmental Science
#>   baseURL: https://ws.pangaea.de/oai/provider
#>   protocolVersion: 2.0
#>   adminEmail: tech@pangaea.de
#>   adminEmail: tech@pangaea.de
#>   earliestDatestamp: 2015-01-01T00:00:00Z
#>   deletedRecord: transient
#>   granularity: YYYY-MM-DDThh:mm:ssZ
#>   compression: gzip
#>   description: oaipangaea.de:oai:pangaea.de:doi:10.1594/PANGAEA.999999
```

### List metadata formats


```r
pg_list_metadata_formats()
#>   metadataPrefix                                                 schema
#> 1         oai_dc         http://www.openarchives.org/OAI/2.0/oai_dc.xsd
#> 2         pan_md      http://ws.pangaea.de/schemas/pangaea/MetaData.xsd
#> 3            dif http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/dif_v9.4.xsd
#> 4       iso19139               http://www.isotc211.org/2005/gmd/gmd.xsd
#> 5  iso19139.iodp               http://www.isotc211.org/2005/gmd/gmd.xsd
#> 6      datacite3  http://schema.datacite.org/meta/kernel-3/metadata.xsd
#>                             metadataNamespace
#> 1 http://www.openarchives.org/OAI/2.0/oai_dc/
#> 2              http://www.pangaea.de/MetaData
#> 3  http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/
#> 4            http://www.isotc211.org/2005/gmd
#> 5            http://www.isotc211.org/2005/gmd
#> 6         http://datacite.org/schema/kernel-3
```

### List identifiers


```r
pg_list_identifiers(from = Sys.Date() - 2, until = Sys.Date())
#> # A tibble: 20,528 × 7
#>                                   identifier            datestamp setSpec
#>                                        <chr>                <chr>   <chr>
#> 1   oai:pangaea.de:doi:10.1594/PANGAEA.52692 2017-03-05T14:44:38Z citable
#> 2   oai:pangaea.de:doi:10.1594/PANGAEA.53178 2017-03-05T14:26:18Z citable
#> 3   oai:pangaea.de:doi:10.1594/PANGAEA.57539 2017-03-05T14:25:32Z citable
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.142421 2017-03-05T13:53:45Z citable
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.149998 2017-03-05T13:59:10Z citable
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.149999 2017-03-07T09:22:22Z citable
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.208129 2017-03-05T14:35:04Z citable
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.228741 2017-03-05T13:59:25Z citable
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.314690 2017-03-07T11:47:26Z citable
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.547798 2017-03-05T13:40:00Z citable
#> # ... with 20,518 more rows, and 4 more variables: setSpec.1 <chr>,
#> #   setSpec.2 <chr>, setSpec.3 <chr>, setSpec.4 <chr>
```

### List sets


```r
pg_list_sets()
#> # A tibble: 257 × 2
#>      setSpec                                        setName
#>        <chr>                                          <chr>
#> 1        ACD       PANGAEA tech-keyword 'ACD' (2 data sets)
#> 2       ASPS     PANGAEA tech-keyword 'ASPS' (59 data sets)
#> 3  AWIXRFraw PANGAEA tech-keyword 'AWIXRFraw' (1 data sets)
#> 4    BAH1960   PANGAEA tech-keyword 'BAH1960' (2 data sets)
#> 5    BAH1961   PANGAEA tech-keyword 'BAH1961' (2 data sets)
#> 6    BAH1962   PANGAEA tech-keyword 'BAH1962' (7 data sets)
#> 7    BAH1963   PANGAEA tech-keyword 'BAH1963' (7 data sets)
#> 8    BAH1964   PANGAEA tech-keyword 'BAH1964' (7 data sets)
#> 9    BAH1965   PANGAEA tech-keyword 'BAH1965' (7 data sets)
#> 10   BAH1966   PANGAEA tech-keyword 'BAH1966' (6 data sets)
#> # ... with 247 more rows
```

### List records


```r
pg_list_records(from = Sys.Date() - 1, until = Sys.Date())
#> # A tibble: 1,450 × 587
#>                                   identifier            datestamp setSpec
#>                                        <chr>                <chr>   <chr>
#> 1  oai:pangaea.de:doi:10.1594/PANGAEA.149999 2017-03-07T09:22:22Z citable
#> 2  oai:pangaea.de:doi:10.1594/PANGAEA.314690 2017-03-07T11:47:26Z citable
#> 3  oai:pangaea.de:doi:10.1594/PANGAEA.611095 2017-03-07T11:01:44Z citable
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.716835 2017-03-07T10:52:54Z citable
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.728847 2017-03-07T13:17:12Z citable
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.735539 2017-03-07T13:19:15Z citable
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.737438 2017-03-06T15:40:27Z citable
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.745833 2017-03-07T13:19:13Z citable
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.746016 2017-03-07T09:22:25Z citable
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.753644 2017-03-07T11:44:13Z citable
#> # ... with 1,440 more rows, and 584 more variables: setSpec.1 <chr>,
#> #   setSpec.2 <chr>, title <chr>, creator <chr>, source <chr>,
#> #   publisher <chr>, date <chr>, type <chr>, format <chr>,
#> #   identifier.2 <chr>, identifier.1 <chr>, description <chr>,
#> #   language <chr>, rights <chr>, rights.1 <chr>, relation <chr>,
#> #   relation.1 <chr>, relation.2 <chr>, relation.3 <chr>,
#> #   relation.4 <chr>, relation.5 <chr>, relation.6 <chr>,
#> #   relation.7 <chr>, relation.8 <chr>, relation.9 <chr>,
#> #   relation.10 <chr>, relation.11 <chr>, relation.12 <chr>,
#> #   relation.13 <chr>, relation.14 <chr>, relation.15 <chr>,
#> #   relation.16 <chr>, relation.17 <chr>, relation.18 <chr>,
#> #   relation.19 <chr>, relation.20 <chr>, relation.21 <chr>,
#> #   relation.22 <chr>, relation.23 <chr>, relation.24 <chr>,
#> #   relation.25 <chr>, relation.26 <chr>, relation.27 <chr>,
#> #   relation.28 <chr>, relation.29 <chr>, relation.30 <chr>,
#> #   relation.31 <chr>, relation.32 <chr>, relation.33 <chr>,
#> #   relation.34 <chr>, relation.35 <chr>, relation.36 <chr>,
#> #   relation.37 <chr>, relation.38 <chr>, relation.39 <chr>,
#> #   relation.40 <chr>, relation.41 <chr>, relation.42 <chr>,
#> #   relation.43 <chr>, relation.44 <chr>, relation.45 <chr>,
#> #   relation.46 <chr>, relation.47 <chr>, relation.48 <chr>,
#> #   relation.49 <chr>, relation.50 <chr>, relation.51 <chr>,
#> #   relation.52 <chr>, relation.53 <chr>, relation.54 <chr>,
#> #   relation.55 <chr>, relation.56 <chr>, relation.57 <chr>,
#> #   relation.58 <chr>, relation.59 <chr>, relation.60 <chr>,
#> #   relation.61 <chr>, relation.62 <chr>, relation.63 <chr>,
#> #   relation.64 <chr>, relation.65 <chr>, relation.66 <chr>,
#> #   relation.67 <chr>, relation.68 <chr>, relation.69 <chr>,
#> #   relation.70 <chr>, relation.71 <chr>, relation.72 <chr>,
#> #   relation.73 <chr>, relation.74 <chr>, relation.75 <chr>,
#> #   relation.76 <chr>, relation.77 <chr>, relation.78 <chr>,
#> #   relation.79 <chr>, relation.80 <chr>, relation.81 <chr>,
#> #   relation.82 <chr>, relation.83 <chr>, relation.84 <chr>, ...
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$header
#> # A tibble: 1 × 3
#>                                  identifier            datestamp
#>                                       <chr>                <chr>
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2016-06-25T14:58:45Z
#> # ... with 1 more variables: setSpec <chr>
#>
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$metadata
#> # A tibble: 1 × 13
#>                                                                         title
#>                                                                         <chr>
#> 1 Trace metals in shells of mussels and clams from deep-sea hydrothermal vent
#> # ... with 12 more variables: creator <chr>, source <chr>,
#> #   publisher <chr>, date <chr>, type <chr>, format <chr>,
#> #   identifier <chr>, description <chr>, language <chr>, rights <chr>,
#> #   coverage <chr>, subject <chr>
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
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ro_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
