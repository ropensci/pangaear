pangaear
========



[![cran checks](https://cranchecks.info/badges/worst/pangaear)](https://cranchecks.info/pkgs/pangaear)
[![Build Status](https://travis-ci.org/ropensci/pangaear.svg?branch=master)](https://travis-ci.org/ropensci/pangaear)
[![Build status](https://ci.appveyor.com/api/projects/status/564oioj2oyefax08?svg=true)](https://ci.appveyor.com/project/sckott/pangaear)
[![codecov](https://codecov.io/gh/ropensci/pangaear/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/pangaear)
[![rstudio mirror downloads](https://cranlogs.r-pkg.org/badges/pangaear)](https://github.com/metacran/cranlogs.app)
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
#> # A tibble: 3 x 6
#>   score doi       size size_measure citation          supplement_to        
#>   <dbl> <chr>    <dbl> <chr>        <chr>             <chr>                
#> 1 12.8  10.1594…     2 datasets     Simonyan, AV; Du… Simonyan, AV; Dultz,…
#> 2  8.71 10.1594…   598 data points  WOCE Surface Vel… <NA>                 
#> 3  8.70 10.1594… 11390 data points  WOCE Upper Ocean… <NA>
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
#>    Event `Date/Time` Latitude Longitude `Elevation [m]` `Depth water [m…
#>    <chr> <chr>          <dbl>     <dbl>           <int>            <dbl>
#>  1 M36/… 1996-10-14…     49.0     -16.5           -4802             0   
#>  2 M36/… 1996-10-14…     49.0     -16.5           -4802             0.99
#>  3 M36/… 1996-10-14…     49.0     -16.5           -4802             1.98
#>  4 M36/… 1996-10-14…     49.0     -16.5           -4802             2.97
#>  5 M36/… 1996-10-14…     49.0     -16.5           -4802             3.96
#>  6 M36/… 1996-10-14…     49.0     -16.5           -4802             4.96
#>  7 M36/… 1996-10-14…     49.0     -16.5           -4802             5.95
#>  8 M36/… 1996-10-14…     49.0     -16.5           -4802             6.94
#>  9 M36/… 1996-10-14…     49.0     -16.5           -4802             7.93
#> 10 M36/… 1996-10-14…     49.0     -16.5           -4802             8.92
#> # … with 32,169 more rows, and 7 more variables: `Press [dbar]` <int>,
#> #   `Temp [°C]` <dbl>, Sal <dbl>, `Tpot [°C]` <dbl>, `Sigma-theta
#> #   [kg/m**3]` <dbl>, `Sigma in situ [kg/m**3]` <dbl>, `Cond
#> #   [mS/cm]` <dbl>
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.325191
#>   parent doi: 10.1594/PANGAEA.325191
#>   url:        https://doi.org/10.1594/PANGAEA.325191
#>   citation:   WOCE Upper Ocean Thermal, UOT (2005): Water temperature XBT profiles from cruise 181991002 (DCQC). Marine Environmental Data Services Branch, Ontario, PANGAEA, https://doi.org/10.1594/PANGAEA.325191
#>   path:       /Users/sckott/Library/Caches/R/pangaear/10_1594_PANGAEA_325191.txt
#>   data:
#> # A tibble: 5,695 x 6
#>    `Date/Time` Latitude Longitude `Depth water [m… `Temp [°C]`
#>    <chr>          <dbl>     <dbl>            <int> <chr>      
#>  1 1991-03-26…     38.6     -124.                1 10.57      
#>  2 1991-03-26…     38.6     -124.                2 10.75      
#>  3 1991-03-26…     38.6     -124.                3 10.89      
#>  4 1991-03-26…     38.6     -124.                4 10.96      
#>  5 1991-03-26…     38.6     -124.                5 11.04      
#>  6 1991-03-26…     38.6     -124.                6 11.09      
#>  7 1991-03-26…     38.6     -124.                7 11.12      
#>  8 1991-03-26…     38.6     -124.                8 11.13      
#>  9 1991-03-26…     38.6     -124.                9 11.15      
#> 10 1991-03-26…     38.6     -124.               10 11.15      
#> # … with 5,685 more rows, and 1 more variable: `Sample label` <chr>
#> 
#> [[2]]
#> NULL
#> 
#> [[3]]
#> NULL
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
#>   metadataPrefix                                                  schema
#> 1         oai_dc          http://www.openarchives.org/OAI/2.0/oai_dc.xsd
#> 2         pan_md       http://ws.pangaea.de/schemas/pangaea/MetaData.xsd
#> 3            dif  http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/dif_v9.4.xsd
#> 4       iso19139                http://www.isotc211.org/2005/gmd/gmd.xsd
#> 5  iso19139.iodp                http://www.isotc211.org/2005/gmd/gmd.xsd
#> 6      datacite3   http://schema.datacite.org/meta/kernel-3/metadata.xsd
#> 7      datacite4 http://schema.datacite.org/meta/kernel-4.1/metadata.xsd
#>                             metadataNamespace
#> 1 http://www.openarchives.org/OAI/2.0/oai_dc/
#> 2              http://www.pangaea.de/MetaData
#> 3  http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/
#> 4            http://www.isotc211.org/2005/gmd
#> 5            http://www.isotc211.org/2005/gmd
#> 6         http://datacite.org/schema/kernel-3
#> 7         http://datacite.org/schema/kernel-4
```

### List identifiers


```r
pg_list_identifiers(from = Sys.Date() - 2, until = Sys.Date())
#> # A tibble: 893 x 10
#>    identifier datestamp setSpec setSpec.1 setSpec.2 setSpec.3 setSpec.4
#>    <chr>      <chr>     <chr>   <chr>     <chr>     <chr>     <chr>    
#>  1 oai:panga… 2019-09-… citable suppleme… topicBio… topicPal… <NA>     
#>  2 oai:panga… 2019-09-… citable suppleme… <NA>      <NA>      <NA>     
#>  3 oai:panga… 2019-09-… citable suppleme… topicOce… <NA>      <NA>     
#>  4 oai:panga… 2019-09-… citable suppleme… topicChe… topicLit… <NA>     
#>  5 oai:panga… 2019-09-… citable suppleme… topicChe… topicLit… <NA>     
#>  6 oai:panga… 2019-09-… citable suppleme… topicGeo… <NA>      <NA>     
#>  7 oai:panga… 2019-09-… citable suppleme… topicLit… topicOce… <NA>     
#>  8 oai:panga… 2019-09-… citable topicEco… topicLit… <NA>      <NA>     
#>  9 oai:panga… 2019-09-… citable suppleme… topicLan… topicLit… <NA>     
#> 10 oai:panga… 2019-09-… citable suppleme… topicBio… topicEco… topicOce…
#> # … with 883 more rows, and 3 more variables: setSpec.5 <chr>,
#> #   setSpec.6 <chr>, setSpec.7 <chr>
```

### List sets


```r
pg_list_sets()
#> # A tibble: 282 x 2
#>    setSpec   setName                                        
#>    <chr>     <chr>                                          
#>  1 ACD       PANGAEA set / keyword 'ACD' (2 data sets)      
#>  2 ASPS      PANGAEA set / keyword 'ASPS' (59 data sets)    
#>  3 AWIXRFraw PANGAEA set / keyword 'AWIXRFraw' (1 data sets)
#>  4 BAH1960   PANGAEA set / keyword 'BAH1960' (2 data sets)  
#>  5 BAH1961   PANGAEA set / keyword 'BAH1961' (2 data sets)  
#>  6 BAH1962   PANGAEA set / keyword 'BAH1962' (7 data sets)  
#>  7 BAH1963   PANGAEA set / keyword 'BAH1963' (7 data sets)  
#>  8 BAH1964   PANGAEA set / keyword 'BAH1964' (7 data sets)  
#>  9 BAH1965   PANGAEA set / keyword 'BAH1965' (7 data sets)  
#> 10 BAH1966   PANGAEA set / keyword 'BAH1966' (6 data sets)  
#> # … with 272 more rows
```

### List records


```r
pg_list_records(from = Sys.Date() - 1, until = Sys.Date())
#> # A tibble: 670 x 121
#>    identifier datestamp setSpec setSpec.1 setSpec.2 setSpec.3 title creator
#>    <chr>      <chr>     <chr>   <chr>     <chr>     <chr>     <chr> <chr>  
#>  1 oai:panga… 2019-09-… citable suppleme… topicBio… topicPal… Calc… Hildeb…
#>  2 oai:panga… 2019-09-… citable suppleme… <NA>      <NA>      Mari… Schefu…
#>  3 oai:panga… 2019-09-… citable suppleme… topicOce… <NA>      Lipi… Schefu…
#>  4 oai:panga… 2019-09-… citable suppleme… topicChe… topicLit… Age … Verste…
#>  5 oai:panga… 2019-09-… citable suppleme… topicChe… topicLit… Comp… Liu, X…
#>  6 oai:panga… 2019-09-… citable suppleme… topicGeo… <NA>      Alke… Leider…
#>  7 oai:panga… 2019-09-… citable suppleme… topicLit… topicOce… Sedi… Verste…
#>  8 oai:panga… 2019-09-… citable suppleme… topicLan… topicLit… Radi… Chen, …
#>  9 oai:panga… 2019-09-… citable suppleme… topicBio… topicEco… Dino… Zonnev…
#> 10 oai:panga… 2019-09-… citable suppleme… <NA>      <NA>      Paly… Averdi…
#> # … with 660 more rows, and 113 more variables: creator.1 <chr>,
#> #   creator.2 <chr>, source <chr>, publisher <chr>, date <chr>,
#> #   type <chr>, format <chr>, identifier.2 <chr>, identifier.1 <chr>,
#> #   description <chr>, language <chr>, rights <chr>, rights.1 <chr>,
#> #   relation <chr>, coverage <chr>, subject <chr>, creator.3 <chr>,
#> #   creator.4 <chr>, creator.5 <chr>, setSpec.4 <chr>, creator.6 <chr>,
#> #   creator.7 <chr>, creator.8 <chr>, creator.9 <chr>, creator.10 <chr>,
#> #   relation.1 <chr>, creator.11 <chr>, creator.12 <chr>,
#> #   creator.13 <chr>, relation.2 <chr>, relation.3 <chr>,
#> #   relation.4 <chr>, setSpec.5 <chr>, setSpec.6 <chr>, setSpec.7 <chr>,
#> #   creator.14 <chr>, creator.15 <chr>, creator.16 <chr>,
#> #   creator.17 <chr>, creator.18 <chr>, creator.19 <chr>,
#> #   creator.20 <chr>, creator.21 <chr>, creator.22 <chr>,
#> #   creator.23 <chr>, creator.24 <chr>, creator.25 <chr>,
#> #   creator.26 <chr>, creator.27 <chr>, creator.28 <chr>,
#> #   creator.29 <chr>, creator.30 <chr>, creator.31 <chr>,
#> #   creator.32 <chr>, creator.33 <chr>, creator.34 <chr>,
#> #   creator.35 <chr>, creator.36 <chr>, creator.37 <chr>,
#> #   creator.38 <chr>, creator.39 <chr>, creator.40 <chr>,
#> #   creator.41 <chr>, relation.5 <chr>, relation.6 <chr>,
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
#> #   relation.40 <chr>, relation.41 <chr>, …
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$header
#> # A tibble: 1 x 3
#>   identifier                  datestamp       setSpec                      
#>   <chr>                       <chr>           <chr>                        
#> 1 oai:pangaea.de:doi:10.1594… 2019-02-13T10:… citable;supplement;topicChem…
#> 
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$metadata
#> # A tibble: 1 x 13
#>   title creator source publisher date  type  format identifier description
#>   <chr> <chr>   <chr>  <chr>     <chr> <chr> <chr>  <chr>      <chr>      
#> 1 Trac… Demina… P.P. … PANGAEA   2012… Data… appli… https://d… Bioaccumul…
#> # … with 4 more variables: language <chr>, rights <chr>, coverage <chr>,
#> #   subject <chr>
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
* Please note that this project is released with a [Contributor Code of Conduct][coc].
By participating in this project you agree to abide by its terms.

[![ro_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[coc]: https://github.com/ropensci/pangaear/blob/master/CODE_OF_CONDUCT.md
