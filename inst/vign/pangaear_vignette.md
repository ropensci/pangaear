<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{Introduction to pangaear}
%\VignetteEncoding{UTF-8}
-->



Introduction to pangaear
========================

`pangaear` is a data retrieval interface for the World Data Center PANGAEA (https://www.pangaea.de/). PANGAEA archieves published Earth & Environmental Science data under the following subjects: agriculture, atmosphere, biological classification, biosphere, chemistry, cryosphere, ecology, fisheries, geophysics, human dimensions, lakes & rives, land surface, lithosphere, oceans, and paleontology.

## Installation

If you've not installed it yet, install from CRAN:


```r
install.packages("pangaear")
```

Or the development version:


```r
devtools::install_github("ropensci/pangaear")
```

## Load pangaear


```r
library("pangaear")
```

## Search for data

`pg_search` is a thin wrapper around the GUI search interface on the page <https://www.pangaea.de/>. Everything you can do there, you can do here.

For example, query for the term 'water', with a bounding box, and return only three results.


```r
pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
```

```
#> # A tibble: 3 x 6
#>   score doi       size size_measure citation          supplement_to        
#>   <dbl> <chr>    <dbl> <chr>        <chr>             <chr>                
#> 1 12.8  10.1594…     2 datasets     Simonyan, AV; Du… Simonyan, AV; Dultz,…
#> 2  8.70 10.1594…   598 data points  WOCE Surface Vel… <NA>                 
#> 3  8.70 10.1594… 11390 data points  WOCE Upper Ocean… <NA>
```

The resulting `data.frame` has details about different studies, and you can use the DOIs (Digital Object Identifiers) to get data and metadata for any studies you're interested in.

### Another search option

There's another search option with the `pg_search_es` function. It is an interface to the Pangaea Elasticsearch interface. This provides a very flexible interface for search Pangaea data - though it is different from what you're used to with the Pangaea website. 


```r
(res <- pg_search_es())
```

```
#> # A tibble: 10 x 41
#>    `_index` `_type` `_id` `_score` `_source.intern… `_source.minEle…
#>  * <chr>    <chr>   <chr>    <dbl> <chr>                       <dbl>
#>  1 pangaea… panmd   8387…        1 2018-09-27T17:1…             0.35
#>  2 pangaea… panmd   7179…        1 2018-10-29T17:5…             2   
#>  3 pangaea… panmd   7913…        1 2018-09-27T19:3…           198.  
#>  4 pangaea… panmd   7791…        1 2018-09-27T20:0…            65.0 
#>  5 pangaea… panmd   7198…        1 2018-10-29T17:4…             2   
#>  6 pangaea… panmd   8363…        1 2018-09-27T17:2…             2.85
#>  7 pangaea… panmd   8255…        1 2018-09-27T17:5…             3.72
#>  8 pangaea… panmd   7950…        1 2018-09-27T19:2…             0   
#>  9 pangaea… panmd   7993…        1 2018-09-27T19:1…           318.  
#> 10 pangaea… panmd   8289…        1 2018-09-27T17:4…             0   
#> # … with 35 more variables: `_source.sf-authortitle` <chr>,
#> #   `_source.techKeyword` <list>, `_source.geocodes` <list>,
#> #   `_source.sp-loginOption` <int>, `_source.agg-author` <list>,
#> #   `_source.eastBoundLongitude` <dbl>, `_source.URI` <chr>,
#> #   `_source.agg-pubYear` <int>, `_source.agg-geometry` <chr>,
#> #   `_source.xml-thumb` <chr>, `_source.xml` <chr>,
#> #   `_source.sf-idDataSet` <int>, `_source.elevationGeocode` <chr>,
#> #   `_source.xml-sitemap` <chr>, `_source.westBoundLongitude` <dbl>,
#> #   `_source.northBoundLatitude` <dbl>, `_source.sp-dataStatus` <int>,
#> #   `_source.nDataPoints` <int>, `_source.sp-hidden` <lgl>,
#> #   `_source.agg-location` <list>, `_source.internal-source` <chr>,
#> #   `_source.southBoundLatitude` <dbl>, `_source.boost` <dbl>,
#> #   `_source.oaiSet` <list>, `_source.maxElevation` <dbl>,
#> #   `_source.agg-campaign` <chr>, `_source.minDateTime` <chr>,
#> #   `_source.agg-mainTopic` <list>, `_source.maxDateTime` <chr>,
#> #   `_source.agg-topic` <list>, `_source.agg-project` <list>,
#> #   `_source.agg-device` <chr>, `_source.agg-basis` <chr>,
#> #   `_source.meanPosition.lat` <dbl>, `_source.meanPosition.lon` <dbl>
```

The returned data.frame has a lot of columns. You can limit columns returned with the `source` parameter.

There are attributes on the data.frame that give you the total number of results found as well as the max score found. 


```r
attributes(res)
```

```
#> $names
#>  [1] "_index"                     "_type"                     
#>  [3] "_id"                        "_score"                    
#>  [5] "_source.internal-datestamp" "_source.minElevation"      
#>  [7] "_source.sf-authortitle"     "_source.techKeyword"       
#>  [9] "_source.geocodes"           "_source.sp-loginOption"    
#> [11] "_source.agg-author"         "_source.eastBoundLongitude"
#> [13] "_source.URI"                "_source.agg-pubYear"       
#> [15] "_source.agg-geometry"       "_source.xml-thumb"         
#> [17] "_source.xml"                "_source.sf-idDataSet"      
#> [19] "_source.elevationGeocode"   "_source.xml-sitemap"       
#> [21] "_source.westBoundLongitude" "_source.northBoundLatitude"
#> [23] "_source.sp-dataStatus"      "_source.nDataPoints"       
#> [25] "_source.sp-hidden"          "_source.agg-location"      
#> [27] "_source.internal-source"    "_source.southBoundLatitude"
#> [29] "_source.boost"              "_source.oaiSet"            
#> [31] "_source.maxElevation"       "_source.agg-campaign"      
#> [33] "_source.minDateTime"        "_source.agg-mainTopic"     
#> [35] "_source.maxDateTime"        "_source.agg-topic"         
#> [37] "_source.agg-project"        "_source.agg-device"        
#> [39] "_source.agg-basis"          "_source.meanPosition.lat"  
#> [41] "_source.meanPosition.lon"  
#> 
#> $row.names
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> 
#> $class
#> [1] "tbl_df"     "tbl"        "data.frame"
#> 
#> $total
#> [1] 386124
#> 
#> $max_score
#> [1] 1
```

```r
attr(res, "total")
```

```
#> [1] 386124
```

```r
attr(res, "max_score")
```

```
#> [1] 1
```

To get to the DOIs for each study, use 


```r
gsub("https://doi.org/", "", res$`_source.URI`)
```

```
#>  [1] "10.1594/PANGAEA.838718" "10.1594/PANGAEA.717974"
#>  [3] "10.1594/PANGAEA.791357" "10.1594/PANGAEA.779192"
#>  [5] "10.1594/PANGAEA.719864" "10.1594/PANGAEA.836369"
#>  [7] "10.1594/PANGAEA.825583" "10.1594/PANGAEA.795004"
#>  [9] "10.1594/PANGAEA.799338" "10.1594/PANGAEA.828908"
```


## Get data

The function `pg_data` fetches datasets for studies by their DOIs.


```r
res <- pg_data(doi = '10.1594/PANGAEA.807580')
res[[1]]
```

```
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

Search for data then pass one or more DOIs to the `pg_data` function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
```

```
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

[OAI-PMH](https://wiki.pangaea.de/wiki/OAI-PMH) is a standard protocol for serving metadata around objects, in this case datasets. If you are already familiar with OAI-PMH you are in luck as you can can use what you know here. If not familiar, it's relatively straight-forward. 

Note that you can't get data through these functions, rather only metadata about datasets.

### Identify the service


```r
pg_identify()
```

```
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
```

```
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
```

```
#> # A tibble: 514 x 11
#>    identifier datestamp setSpec setSpec.1 setSpec.2 setSpec.3 setSpec.4
#>    <chr>      <chr>     <chr>   <chr>     <chr>     <chr>     <chr>    
#>  1 oai:panga… 2019-08-… citable hmmv      suppleme… topicOce… <NA>     
#>  2 oai:panga… 2019-08-… citable suppleme… <NA>      <NA>      <NA>     
#>  3 oai:panga… 2019-08-… citable suppleme… <NA>      <NA>      <NA>     
#>  4 oai:panga… 2019-08-… citable suppleme… topicBio… topicEco… topicOce…
#>  5 oai:panga… 2019-08-… citable suppleme… <NA>      <NA>      <NA>     
#>  6 oai:panga… 2019-08-… citable suppleme… <NA>      <NA>      <NA>     
#>  7 oai:panga… 2019-08-… citable suppleme… topicLit… topicOce… topicPal…
#>  8 oai:panga… 2019-08-… citable suppleme… topicLan… topicLit… topicPal…
#>  9 oai:panga… 2019-08-… citable suppleme… topicChe… topicGeo… topicLit…
#> 10 oai:panga… 2019-08-… citable suppleme… topicLan… topicLit… <NA>     
#> # … with 504 more rows, and 4 more variables: setSpec.5 <chr>,
#> #   setSpec.6 <chr>, setSpec.7 <chr>, setSpec.8 <chr>
```

### List sets


```r
pg_list_sets()
```

```
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
```

```
#> # A tibble: 331 x 586
#>    identifier datestamp setSpec setSpec.1 setSpec.2 setSpec.3 setSpec.4
#>    <chr>      <chr>     <chr>   <chr>     <chr>     <chr>     <chr>    
#>  1 oai:panga… 2019-08-… citable suppleme… topicBio… topicEco… topicOce…
#>  2 oai:panga… 2019-08-… citable suppleme… <NA>      <NA>      <NA>     
#>  3 oai:panga… 2019-08-… citable suppleme… topicLit… topicOce… topicPal…
#>  4 oai:panga… 2019-08-… citable suppleme… topicLan… topicLit… topicPal…
#>  5 oai:panga… 2019-08-… citable <NA>      <NA>      <NA>      <NA>     
#>  6 oai:panga… 2019-08-… citable suppleme… topicLit… <NA>      <NA>     
#>  7 oai:panga… 2019-08-… BCCR    suppleme… topicLan… topicLit… <NA>     
#>  8 oai:panga… 2019-08-… citable suppleme… <NA>      <NA>      <NA>     
#>  9 oai:panga… 2019-08-… citable <NA>      <NA>      <NA>      <NA>     
#> 10 oai:panga… 2019-08-… citable suppleme… topicLit… <NA>      <NA>     
#> # … with 321 more rows, and 579 more variables: title <chr>,
#> #   creator <chr>, creator.1 <chr>, creator.2 <chr>, creator.3 <chr>,
#> #   source <chr>, publisher <chr>, date <chr>, type <chr>, format <chr>,
#> #   identifier.2 <chr>, identifier.1 <chr>, description <chr>,
#> #   language <chr>, rights <chr>, rights.1 <chr>, coverage <chr>,
#> #   subject <chr>, creator.4 <chr>, relation <chr>, creator.5 <chr>,
#> #   creator.6 <chr>, creator.7 <chr>, creator.8 <chr>, creator.9 <chr>,
#> #   creator.10 <chr>, creator.11 <chr>, relation.1 <chr>,
#> #   relation.2 <chr>, relation.3 <chr>, relation.4 <chr>,
#> #   relation.5 <chr>, relation.6 <chr>, relation.7 <chr>,
#> #   relation.8 <chr>, relation.9 <chr>, relation.10 <chr>,
#> #   relation.11 <chr>, relation.12 <chr>, relation.13 <chr>,
#> #   relation.14 <chr>, relation.15 <chr>, relation.16 <chr>,
#> #   relation.17 <chr>, relation.18 <chr>, relation.19 <chr>,
#> #   relation.20 <chr>, relation.21 <chr>, relation.22 <chr>,
#> #   relation.23 <chr>, relation.24 <chr>, relation.25 <chr>,
#> #   relation.26 <chr>, relation.27 <chr>, relation.28 <chr>,
#> #   relation.29 <chr>, relation.30 <chr>, relation.31 <chr>,
#> #   relation.32 <chr>, relation.33 <chr>, relation.34 <chr>,
#> #   relation.35 <chr>, relation.36 <chr>, relation.37 <chr>,
#> #   relation.38 <chr>, relation.39 <chr>, relation.40 <chr>,
#> #   relation.41 <chr>, relation.42 <chr>, relation.43 <chr>,
#> #   relation.44 <chr>, relation.45 <chr>, relation.46 <chr>,
#> #   relation.47 <chr>, relation.48 <chr>, relation.49 <chr>,
#> #   relation.50 <chr>, relation.51 <chr>, relation.52 <chr>,
#> #   relation.53 <chr>, relation.54 <chr>, relation.55 <chr>,
#> #   relation.56 <chr>, relation.57 <chr>, relation.58 <chr>,
#> #   relation.59 <chr>, relation.60 <chr>, relation.61 <chr>,
#> #   relation.62 <chr>, relation.63 <chr>, relation.64 <chr>,
#> #   relation.65 <chr>, relation.66 <chr>, relation.67 <chr>,
#> #   relation.68 <chr>, relation.69 <chr>, relation.70 <chr>,
#> #   relation.71 <chr>, relation.72 <chr>, relation.73 <chr>, …
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
```

```
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
