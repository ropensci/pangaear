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
#>   score doi       size size_measure citation         supplement_to        
#>   <dbl> <chr>    <dbl> <chr>        <chr>            <chr>                
#> 1  21.2 10.1594…     2 datasets     Simonyan, AV; D… Simonyan, AV; Dultz,…
#> 2  13.6 10.1594…     5 datasets     Cooper, MG; Sch… Cooper, MG; Schapero…
#> 3  11.3 10.1594…  4152 data points  Uhlig, C; Loose… Uhlig, C; Loose, B (…
```

## Get data


```r
res <- pg_data(doi = '10.1594/PANGAEA.807580')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.807580
#>   parent doi: 10.1594/PANGAEA.807580
#>   url:        https://doi.org/10.1594/PANGAEA.807580
#>   citation:   Schiebel, Ralf; Waniek, Joanna J; Bork, Matthias; Hemleben, Christoph (2001): Physical oceanography during METEOR cruise M36/6. PANGAEA, https://doi.org/10.1594/PANGAEA.807580, In supplement to: Schiebel, R et al. (2001): Planktic foraminiferal production stimulated by chlorophyll redistribution and entrainment of nutrients. Deep Sea Research Part I: Oceanographic Research Papers, 48(3), 721-740, https://doi.org/10.1016/S0967-0637(00)00065-0
#>   path:       /Users/sckott/Library/Caches/pangaear/10_1594_PANGAEA_807580.txt
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
#> # ... with 32,169 more rows, and 7 more variables: `Press [dbar]` <int>,
#> #   `Temp [°C]` <dbl>, Sal <dbl>, `Tpot [°C]` <dbl>, `Sigma-theta
#> #   [kg/m**3]` <dbl>, `Sigma in situ [kg/m**3]` <dbl>, `Cond
#> #   [mS/cm]` <dbl>
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.874893
#>   parent doi: 10.1594/PANGAEA.874893
#>   url:        https://doi.org/10.1594/PANGAEA.874893
#>   citation:   Uhlig, Christiane; Loose, Brice (2017): Methane oxidation in Arctic seawater, Utqiagvik, Alaska. PANGAEA, https://doi.org/10.1594/PANGAEA.874893, Supplement to: Uhlig, C; Loose, B (2017): Using stable isotopes and gas concentrations for independent constraints on microbial methane oxidation at Arctic Ocean temperatures. Limnology and Oceanography-Methods, 15(8), 737-751, https://doi.org/10.1002/lom3.10199
#>   path:       /Users/sckott/Library/Caches/pangaear/10_1594_PANGAEA_874893.txt
#>   data:
#> # A tibble: 270 x 22
#>    Event `Date/Time` Latitude Longitude `Depth water [m… `Depth top [m]`
#>    <chr> <chr>          <dbl>     <dbl>            <dbl>           <int>
#>  1 Elso… 2016-04-07      71.3     -156.              1.5              NA
#>  2 Elso… 2016-04-07      71.3     -156.              1.5              NA
#>  3 Elso… 2016-04-07      71.3     -156.              1.5              NA
#>  4 Elso… 2016-04-07      71.3     -156.              1.5              NA
#>  5 Utqi… 2016-04-07      71.4     -157.              6.5              NA
#>  6 Utqi… 2016-04-07      71.4     -157.              6.5              NA
#>  7 Utqi… 2016-04-07      71.4     -157.              6.5              NA
#>  8 Utqi… 2016-04-07      71.4     -157.              6.5              NA
#>  9 Utqi… 2016-04-07      71.4     -157.              5                NA
#> 10 Utqi… 2016-04-07      71.4     -157.              5                NA
#> # ... with 260 more rows, and 16 more variables: `Depth bot [m]` <int>,
#> #   `Sample ID` <int>, Treat <chr>, `N [#]` <int>, `Duration
#> #   [days]` <dbl>, `Duration std dev [±]` <dbl>, `CH4 [nmol/l]` <dbl>,
#> #   `CH4 std dev [±]` <dbl>, `ln(CH4) [nmol]` <dbl>, `ln(CH4) std dev
#> #   [±]` <dbl>, `d13C CH4 [per mil PDB]` <dbl>, `d13C CH4 std dev
#> #   [±]` <dbl>, `Y-axis high mean` <dbl>, `Y-axis high std dev [±]` <dbl>,
#> #   `Y-axis low mean` <dbl>, `Y-axis low std dev [±]` <dbl>
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
#> # A tibble: 462 x 10
#>    identifier datestamp setSpec setSpec.1 setSpec.2 setSpec.3 setSpec.4
#>    <chr>      <chr>     <chr>   <chr>     <chr>     <chr>     <chr>    
#>  1 oai:panga… 2018-07-… citable citableW… suppleme… topicChe… topicLan…
#>  2 oai:panga… 2018-08-… citable citableW… suppleme… topicLit… <NA>     
#>  3 oai:panga… 2018-07-… citable citableW… suppleme… topicChe… <NA>     
#>  4 oai:panga… 2018-07-… citable citableW… suppleme… topicBio… topicChe…
#>  5 oai:panga… 2018-08-… citable citableW… suppleme… topicLit… topicOce…
#>  6 oai:panga… 2018-07-… citable citableW… suppleme… <NA>      <NA>     
#>  7 oai:panga… 2018-08-… citable citableW… suppleme… topicOce… <NA>     
#>  8 oai:panga… 2018-07-… citable citableW… suppleme… topicChe… topicLan…
#>  9 oai:panga… 2018-07-… citable citableW… deNBIche… suppleme… topicChe…
#> 10 oai:panga… 2018-08-… citable citableW… suppleme… topicChe… topicLit…
#> # ... with 452 more rows, and 3 more variables: setSpec.5 <chr>,
#> #   setSpec.6 <chr>, setSpec.7 <chr>
```

### List sets


```r
pg_list_sets()
#> # A tibble: 280 x 2
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
#> # ... with 270 more rows
```

### List records


```r
pg_list_records(from = Sys.Date() - 1, until = Sys.Date())
#> # A tibble: 352 x 600
#>    identifier datestamp setSpec setSpec.1 setSpec.2 setSpec.3 title creator
#>    <chr>      <chr>     <chr>   <chr>     <chr>     <chr>     <chr> <chr>  
#>  1 oai:panga… 2018-08-… citable citableW… suppleme… topicLit… Data… Ocean …
#>  2 oai:panga… 2018-08-… citable citableW… suppleme… topicLit… Fora… Bolton…
#>  3 oai:panga… 2018-08-… citable citableW… suppleme… topicOce… Surf… Alderk…
#>  4 oai:panga… 2018-08-… citable citableW… suppleme… topicChe… Seaw… Bednar…
#>  5 oai:panga… 2018-08-… citable citableW… suppleme… topicChe… (Tab… Fretzd…
#>  6 oai:panga… 2018-08-… citable citableW… suppleme… <NA>      Geoc… Fretzd…
#>  7 oai:panga… 2018-08-… citable citableW… topicChe… topicLit… Whol… Beier,…
#>  8 oai:panga… 2018-08-… citable citableW… suppleme… <NA>      Anno… Devey,…
#>  9 oai:panga… 2018-08-… citable citableW… suppleme… topicLit… Vert… Becker…
#> 10 oai:panga… 2018-08-… citable citableW… suppleme… topicLit… Geoc… Becker…
#> # ... with 342 more rows, and 592 more variables: source <chr>,
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
#> #   relation.82 <chr>, relation.83 <chr>, relation.84 <chr>,
#> #   relation.85 <chr>, relation.86 <chr>, relation.87 <chr>,
#> #   relation.88 <chr>, …
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$header
#> # A tibble: 1 x 3
#>   identifier               datestamp     setSpec                          
#>   <chr>                    <chr>         <chr>                            
#> 1 oai:pangaea.de:doi:10.1… 2017-08-08T1… citable;citableWithChilds;supple…
#> 
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$metadata
#> # A tibble: 1 x 13
#>   title creator source publisher date  type  format identifier description
#>   <chr> <chr>   <chr>  <chr>     <chr> <chr> <chr>  <chr>      <chr>      
#> 1 Trac… Demina… P.P. … PANGAEA   2012… Data… appli… https://d… Bioaccumul…
#> # ... with 4 more variables: language <chr>, rights <chr>, coverage <chr>,
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
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ro_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
