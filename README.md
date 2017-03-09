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
#> 1 21.82342 10.1594/PANGAEA.812094     2     datasets
#> 2 11.09736 10.1594/PANGAEA.862525   372     datasets
#> 3 10.92194 10.1594/PANGAEA.736010     9     datasets
#> # ... with 2 more variables: citation <chr>, supplement_to <chr>
```

## Get data


```r
res <- pg_data(doi = '10.1594/PANGAEA.807580')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.807580
#>   parent doi: 10.1594/PANGAEA.807580
#>   url:        https://doi.org/10.1594/PANGAEA.807580
#>   citation:   Schiebel, Ralf; Waniek, Joanna J; Bork, Matthias; Hemleben, Christoph (2001): Physical oceanography during METEOR cruise M36/6. doi:10.1594/PANGAEA.807580,In supplement to: Schiebel, R et al. (2001): Planktic foraminiferal production stimulated by chlorophyll redistribution and entrainment of nutrients. Deep Sea Research Part I: Oceanographic Research Papers, 48(3), 721-740, doi:10.1016/S0967-0637(00)00065-0
#>   path:       /Users/sacmac/Library/Caches/pangaear/10_1594_PANGAEA_807580.txt
#>   data:
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
#>   parent doi: 10.1594/PANGAEA.736010
#>   url:        https://doi.org/10.1594/PANGAEA.77406
#>   citation:   Archer, David E; Devol, Alan H (1992): Benthic oxygen flixes on the Washington shelf and slope. doi:10.1594/PANGAEA.736010,Supplement to: Archer, DE; Devol, AH (1992): Benthic oxygen fluxes on the Washington shelf and slope: A comparison of in situ microelectrode and chamber flux measurements. Limnology and Oceanography, 37(3), 614-629, doi:10.4319/lo.1992.37.3.0614
#>   path:       /Users/sacmac/Library/Caches/pangaear/10_1594_PANGAEA_77406.txt
#>   data:
#> # A tibble: 1 × 4
#>   `Depth [m]` `SOD [mmol/m**2/day]` `SOD [mmol/m**2/day]` `O2 [µmol/l]`
#>         <int>                 <dbl>                 <dbl>         <dbl>
#> 1           0                  1.51                  0.74            25
#> 
#> [[2]]
#> <Pangaea data> 10.1594/PANGAEA.77397
#>   parent doi: 10.1594/PANGAEA.736010
#>   url:        https://doi.org/10.1594/PANGAEA.77397
#>   citation:   Archer, David E; Devol, Alan H (1992): Benthic oxygen flixes on the Washington shelf and slope. doi:10.1594/PANGAEA.736010,Supplement to: Archer, DE; Devol, AH (1992): Benthic oxygen fluxes on the Washington shelf and slope: A comparison of in situ microelectrode and chamber flux measurements. Limnology and Oceanography, 37(3), 614-629, doi:10.4319/lo.1992.37.3.0614
#>   path:       /Users/sacmac/Library/Caches/pangaear/10_1594_PANGAEA_77397.txt
#>   data:
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
#>   parent doi: 10.1594/PANGAEA.736010
#>   url:        https://doi.org/10.1594/PANGAEA.77398
#>   citation:   Archer, David E; Devol, Alan H (1992): Benthic oxygen flixes on the Washington shelf and slope. doi:10.1594/PANGAEA.736010,Supplement to: Archer, DE; Devol, AH (1992): Benthic oxygen fluxes on the Washington shelf and slope: A comparison of in situ microelectrode and chamber flux measurements. Limnology and Oceanography, 37(3), 614-629, doi:10.4319/lo.1992.37.3.0614
#>   path:       /Users/sacmac/Library/Caches/pangaear/10_1594_PANGAEA_77398.txt
#>   data:
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
#> # A tibble: 7,596 × 9
#>                                   identifier            datestamp setSpec
#>                                        <chr>                <chr>   <chr>
#> 1   oai:pangaea.de:doi:10.1594/PANGAEA.55417 2017-03-08T13:19:32Z citable
#> 2   oai:pangaea.de:doi:10.1594/PANGAEA.57910 2017-03-08T13:17:50Z  ORFOIS
#> 3   oai:pangaea.de:doi:10.1594/PANGAEA.77250 2017-03-08T13:19:59Z citable
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.149999 2017-03-07T09:22:22Z citable
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.208129 2017-03-08T13:19:16Z citable
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.314690 2017-03-07T11:47:26Z citable
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.351146 2017-03-08T13:18:19Z citable
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.611095 2017-03-07T11:01:44Z citable
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.693923 2017-03-08T13:17:24Z citable
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.716835 2017-03-07T10:52:54Z citable
#> # ... with 7,586 more rows, and 6 more variables: setSpec.1 <chr>,
#> #   setSpec.2 <chr>, setSpec.3 <chr>, setSpec.4 <chr>, setSpec.5 <chr>,
#> #   setSpec.6 <chr>
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
#> # A tibble: 6,363 × 48
#>                                   identifier            datestamp setSpec         setSpec.1         setSpec.2
#>                                        <chr>                <chr>   <chr>             <chr>             <chr>
#> 1   oai:pangaea.de:doi:10.1594/PANGAEA.55417 2017-03-08T13:19:32Z citable citableWithChilds        supplement
#> 2   oai:pangaea.de:doi:10.1594/PANGAEA.57910 2017-03-08T13:17:50Z  ORFOIS           citable citableWithChilds
#> 3   oai:pangaea.de:doi:10.1594/PANGAEA.77250 2017-03-08T13:19:59Z citable citableWithChilds        supplement
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.208129 2017-03-08T13:19:16Z citable citableWithChilds        supplement
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.351146 2017-03-08T13:18:19Z citable citableWithChilds        supplement
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.693923 2017-03-08T13:17:24Z citable citableWithChilds        supplement
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.726410 2017-03-08T13:17:54Z citable citableWithChilds        supplement
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.757616 2017-03-08T13:18:05Z citable citableWithChilds        supplement
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.758696 2017-03-08T13:19:02Z citable citableWithChilds        supplement
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.760166 2017-03-09T14:54:46Z    BCCR            IMAGES       Past4Future
#> # ... with 6,353 more rows, and 43 more variables: title <chr>, creator <chr>, creator.1 <chr>, source <chr>, publisher <chr>, date <chr>, type <chr>, format <chr>, identifier.2 <chr>,
#> #   identifier.1 <chr>, description <chr>, language <chr>, rights <chr>, rights.1 <chr>, coverage <chr>, subject <chr>, setSpec.3 <chr>, creator.2 <chr>, creator.3 <chr>, relation <chr>,
#> #   relation.1 <chr>, relation.2 <chr>, relation.3 <chr>, relation.4 <chr>, creator.4 <chr>, creator.5 <chr>, creator.6 <chr>, creator.7 <chr>, setSpec.4 <chr>, setSpec.5 <chr>, setSpec.6 <chr>,
#> #   source.1 <chr>, creator.8 <chr>, creator.9 <chr>, creator.10 <chr>, creator.11 <chr>, creator.12 <chr>, creator.13 <chr>, relation.5 <chr>, relation.6 <chr>, relation.7 <chr>, relation.8 <chr>,
#> #   creator.14 <chr>
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$header
#> # A tibble: 1 × 3
#>                                  identifier            datestamp                              setSpec
#>                                       <chr>                <chr>                                <chr>
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2016-06-25T14:58:45Z citable;citableWithChilds;supplement
#> 
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$metadata
#> # A tibble: 1 × 13
#>                                                                                                                                title                                      creator
#>                                                                                                                                <chr>                                        <chr>
#> 1 Trace metals in shells of mussels and clams from deep-sea hydrothermal vent fields of the Mid-Atlantic Ridge and East Pacific Rise Demina, Lyudmila L;Galkin, Sergey V;Dara, OM
#> # ... with 11 more variables: source <chr>, publisher <chr>, date <chr>, type <chr>, format <chr>, identifier <chr>, description <chr>, language <chr>, rights <chr>, coverage <chr>, subject <chr>
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
