pangaear
========



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
#>   score doi                       size size_measure citation  supplement_…
#>   <dbl> <chr>                    <dbl> <chr>        <chr>     <chr>       
#> 1  20.0 10.1594/PANGAEA.812094    2.00 datasets     Simonyan… Simonyan, A…
#> 2  11.0 10.1594/PANGAEA.736010    9.00 datasets     Archer, … Archer, DE;…
#> 3  10.9 10.1594/PANGAEA.874893 4152    data points  Uhlig, C… Uhlig, C; L…
```

## Get data


```r
res <- pg_data(doi = '10.1594/PANGAEA.807580')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.807580
#>   parent doi: 10.1594/PANGAEA.807580
#>   url:        https://doi.org/10.1594/PANGAEA.807580
#>   citation:   Schiebel, Ralf; Waniek, Joanna J; Bork, Matthias; Hemleben, Christoph (2001): Physical oceanography during METEOR cruise M36/6. PANGAEA, https://doi.org/10.1594/PANGAEA.807580,In supplement to: Schiebel, R et al. (2001): Planktic foraminiferal production stimulated by chlorophyll redistribution and entrainment of nutrients. Deep Sea Research Part I: Oceanographic Research Papers, 48(3), 721-740, https://doi.org/10.1016/S0967-0637(00)00065-0
#>   path:       /Users/sckott/Library/Caches/pangaear/10_1594_PANGAEA_807580.txt
#>   data:
#> # A tibble: 32,179 x 13
#>    Event `Dat… Lati… Long… `Ele… `Dep… `Pre… `Tem…   Sal `Tpo… `Sig… `Sig…
#>    <chr> <chr> <dbl> <dbl> <int> <dbl> <int> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 M36/… 1996…  49.0 -16.5 -4802 0         0  15.7  35.7  15.7  26.4  26.4
#>  2 M36/… 1996…  49.0 -16.5 -4802 0.990     1  15.7  35.7  15.7  26.4  26.4
#>  3 M36/… 1996…  49.0 -16.5 -4802 1.98      2  15.7  35.7  15.7  26.4  26.4
#>  4 M36/… 1996…  49.0 -16.5 -4802 2.97      3  15.7  35.7  15.7  26.4  26.4
#>  5 M36/… 1996…  49.0 -16.5 -4802 3.96      4  15.7  35.7  15.7  26.4  26.4
#>  6 M36/… 1996…  49.0 -16.5 -4802 4.96      5  15.7  35.7  15.7  26.4  26.4
#>  7 M36/… 1996…  49.0 -16.5 -4802 5.95      6  15.7  35.7  15.7  26.4  26.4
#>  8 M36/… 1996…  49.0 -16.5 -4802 6.94      7  15.7  35.7  15.7  26.4  26.4
#>  9 M36/… 1996…  49.0 -16.5 -4802 7.93      8  15.7  35.7  15.7  26.4  26.4
#> 10 M36/… 1996…  49.0 -16.5 -4802 8.92      9  15.7  35.7  15.7  26.4  26.4
#> # ... with 32,169 more rows, and 1 more variable: `Cond [mS/cm]` <dbl>
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.874893
#>   parent doi: 10.1594/PANGAEA.874893
#>   url:        https://doi.org/10.1594/PANGAEA.874893
#>   citation:   Uhlig, Christiane; Loose, Brice (2017): Methane oxidation in Arctic seawater, Utqiagvik, Alaska. PANGAEA, https://doi.org/10.1594/PANGAEA.874893,Supplement to: Uhlig, C; Loose, B (2017): Using stable isotopes and gas concentrations for independent constraints on microbial methane oxidation at Arctic Ocean temperatures. Limnology and Oceanography-Methods, 15 pp, https://doi.org/10.1002/lom3.10199
#>   path:       /Users/sckott/Library/Caches/pangaear/10_1594_PANGAEA_874893.txt
#>   data:
#> # A tibble: 270 x 22
#>    Event  `Date… Latit… Longi… `Dep… `Dep… `Dep… `Sam… Treat `N [… `Durat…
#>    <chr>  <chr>   <dbl>  <dbl> <dbl> <int> <int> <int> <chr> <int>   <dbl>
#>  1 Elson… 2016-…   71.3   -156  1.50    NA    NA     7 0.2x…     2  0.0100
#>  2 Elson… 2016-…   71.3   -156  1.50    NA    NA     7 0.2x…     3  6.03  
#>  3 Elson… 2016-…   71.3   -156  1.50    NA    NA     7 0.2x…     2  8.88  
#>  4 Elson… 2016-…   71.3   -156  1.50    NA    NA     7 0.2x…     4 10.8   
#>  5 Utqia… 2016-…   71.4   -157  6.50    NA    NA    10 0.2x      2  0.0100
#>  6 Utqia… 2016-…   71.4   -157  6.50    NA    NA    10 0.2x      2  6.15  
#>  7 Utqia… 2016-…   71.4   -157  6.50    NA    NA    10 0.2x      2  8.99  
#>  8 Utqia… 2016-…   71.4   -157  6.50    NA    NA    10 0.2x      2 10.8   
#>  9 Utqia… 2016-…   71.4   -157  5.00    NA    NA    13 0.2x      2  0.0100
#> 10 Utqia… 2016-…   71.4   -157  5.00    NA    NA    13 0.2x      2  6.15  
#> # ... with 260 more rows, and 11 more variables: `Duration std dev [±]`
#> #   <dbl>, `CH4 [nmol/l]` <dbl>, `CH4 std dev [±]` <dbl>, `ln(CH4) [nmol]`
#> #   <dbl>, `ln(CH4) std dev [±]` <dbl>, `d13C CH4 [per mil PDB]` <dbl>,
#> #   `d13C CH4 std dev [±]` <dbl>, `Y-axis high mean` <dbl>, `Y-axis high
#> #   std dev [±]` <dbl>, `Y-axis low mean` <dbl>, `Y-axis low std dev [±]`
#> #   <dbl>
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
#> # A tibble: 224 x 7
#>    identifier        datestamp  setSpec  setSpec.1 setSpec… setSpe… setSp…
#>    <chr>             <chr>      <chr>    <chr>     <chr>    <chr>   <chr> 
#>  1 oai:pangaea.de:d… 2018-01-0… citable  citableW… deNBIch… supple… <NA>  
#>  2 oai:pangaea.de:d… 2018-01-0… Yangeta… citable   citable… deNBIc… suppl…
#>  3 oai:pangaea.de:d… 2018-01-0… citable  citableW… supplem… <NA>    <NA>  
#>  4 oai:pangaea.de:d… 2018-01-0… citable  citableW… supplem… <NA>    <NA>  
#>  5 oai:pangaea.de:d… 2018-01-0… citable  citableW… supplem… <NA>    <NA>  
#>  6 oai:pangaea.de:d… 2018-01-0… citable  citableW… deNBIch… supple… <NA>  
#>  7 oai:pangaea.de:d… 2018-01-0… citable  citableW… deNBIch… supple… <NA>  
#>  8 oai:pangaea.de:d… 2018-01-0… citable  citableW… deNBIch… supple… <NA>  
#>  9 oai:pangaea.de:d… 2018-01-0… Yangeta… citable   citable… deNBIc… <NA>  
#> 10 oai:pangaea.de:d… 2018-01-0… citable  citableW… <NA>     <NA>    <NA>  
#> # ... with 214 more rows
```

### List sets


```r
pg_list_sets()
#> # A tibble: 262 x 2
#>    setSpec   setName                                       
#>    <chr>     <chr>                                         
#>  1 ACD       PANGAEA tech-keyword 'ACD' (2 data sets)      
#>  2 ASPS      PANGAEA tech-keyword 'ASPS' (59 data sets)    
#>  3 AWIXRFraw PANGAEA tech-keyword 'AWIXRFraw' (1 data sets)
#>  4 BAH1960   PANGAEA tech-keyword 'BAH1960' (2 data sets)  
#>  5 BAH1961   PANGAEA tech-keyword 'BAH1961' (2 data sets)  
#>  6 BAH1962   PANGAEA tech-keyword 'BAH1962' (7 data sets)  
#>  7 BAH1963   PANGAEA tech-keyword 'BAH1963' (7 data sets)  
#>  8 BAH1964   PANGAEA tech-keyword 'BAH1964' (7 data sets)  
#>  9 BAH1965   PANGAEA tech-keyword 'BAH1965' (7 data sets)  
#> 10 BAH1966   PANGAEA tech-keyword 'BAH1966' (6 data sets)  
#> # ... with 252 more rows
```

### List records


```r
pg_list_records(from = Sys.Date() - 1, until = Sys.Date())
#> # A tibble: 173 x 45
#>    iden… date… setS… setS… setS… setS… setS… title crea… crea… crea… crea…
#>    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 oai:… 2018… Yang… cita… cita… deNB… supp… Seaw… de P… McCo… Cohe… Dill…
#>  2 oai:… 2018… cita… cita… supp… <NA>  <NA>  Chem… Cart… <NA>  <NA>  <NA> 
#>  3 oai:… 2018… cita… cita… supp… <NA>  <NA>  Dist… Step… Obro… Hytt… Krup…
#>  4 oai:… 2018… cita… cita… supp… <NA>  <NA>  Desc… Cron… <NA>  <NA>  <NA> 
#>  5 oai:… 2018… cita… cita… deNB… supp… <NA>  Seaw… Dueñ… Rait… de N… Reic…
#>  6 oai:… 2018… cita… cita… deNB… supp… <NA>  Seaw… Ries… <NA>  <NA>  <NA> 
#>  7 oai:… 2018… cita… cita… deNB… supp… <NA>  Seaw… Brad… Warn… Dave… Smit…
#>  8 oai:… 2018… Yang… cita… cita… deNB… <NA>  Seaw… Chau… Deni… Cuet… <NA> 
#>  9 oai:… 2018… cita… cita… <NA>  <NA>  <NA>  The … Llor… Rovi… Meri… Rubi…
#> 10 oai:… 2018… cita… cita… supp… <NA>  <NA>  Seis… Diez… Eise… Hofs… Bohl…
#> # ... with 163 more rows, and 33 more variables: source <chr>, publisher
#> #   <chr>, date <chr>, type <chr>, format <chr>, identifier.2 <chr>,
#> #   identifier.1 <chr>, description <chr>, language <chr>, rights <chr>,
#> #   rights.1 <chr>, subject <chr>, relation <chr>, relation.1 <chr>,
#> #   coverage <chr>, creator.4 <chr>, creator.5 <chr>, creator.6 <chr>,
#> #   creator.7 <chr>, relation.2 <chr>, creator.8 <chr>, creator.9 <chr>,
#> #   source.1 <chr>, relation.3 <chr>, relation.4 <chr>, relation.5 <chr>,
#> #   relation.6 <chr>, relation.7 <chr>, relation.8 <chr>, relation.9
#> #   <chr>, relation.10 <chr>, relation.11 <chr>, relation.12 <chr>
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$header
#> # A tibble: 1 x 3
#>   identifier                                datestamp            setSpec  
#>   <chr>                                     <chr>                <chr>    
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2017-08-08T17:50:18Z citable;…
#> 
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$metadata
#> # A tibble: 1 x 13
#>   title  crea… sour… publ… date  type  form… iden… desc… lang… righ… cove…
#>   <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#> 1 Trace… Demi… P.P.… PANG… 2012… Data… appl… http… Bioa… en    CC-B… MEDI…
#> # ... with 1 more variable: subject <chr>
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
