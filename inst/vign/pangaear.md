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
#>   score doi            size size_measure citation                                                 supplement_to                                                                      
#>   <dbl> <chr>         <dbl> <chr>        <chr>                                                    <chr>                                                                              
#> 1 13.0  10.1594/PANG…     4 datasets     Krylova, EM; Sahling, H; Janssen, R (2010): A new genus… Krylova, EM; Sahling, H; Janssen, R (2010): Abyssogena: a new genus of the family …
#> 2 12.8  10.1594/PANG…     2 datasets     Simonyan, AV; Dultz, S; Behrens, H (2012): Diffusion tr… Simonyan, AV; Dultz, S; Behrens, H (2012): Diffusive transport of water in porous …
#> 3  8.78 10.1594/PANG…  1148 data points  WOCE Surface Velocity Program, SVP (2006): Water temper… <NA>
```

The resulting `data.frame` has details about different studies, and you can use the DOIs (Digital Object Identifiers) to get data and metadata for any studies you're interested in.

### Another search option

There's another search option with the `pg_search_es` function. It is an interface to the Pangaea Elasticsearch interface. This provides a very flexible interface for search Pangaea data - though it is different from what you're used to with the Pangaea website. 


```r
(res <- pg_search_es())
```

```
#> # A tibble: 10 x 46
#>    `_index` `_type` `_id` `_score` `_source.intern… `_source.parent… `_source.minEle… `_source.sf-aut… `_source.parent… `_source.techKe… `_source.geocod… `_source.sp-log…
#>  * <chr>    <chr>   <chr>    <dbl> <chr>            <chr>                       <dbl> <chr>                       <int> <list>           <list>                      <int>
#>  1 pangaea… panmd   9018…        1 2020-01-17T15:1… https://doi.org…             -0.4 Anhaus Philipp#…           901247 <chr [654]>      <chr [5]>                       1
#>  2 pangaea… panmd   9017…        1 2020-01-17T15:1… https://doi.org…              2   Anhaus Philipp#…           901247 <chr [652]>      <chr [5]>                       1
#>  3 pangaea… panmd   9017…        1 2020-01-17T15:1… https://doi.org…              2   Anhaus Philipp#…           901247 <chr [652]>      <chr [5]>                       1
#>  4 pangaea… panmd   9017…        1 2020-01-17T15:1… https://doi.org…              2   Anhaus Philipp#…           901247 <chr [652]>      <chr [5]>                       1
#>  5 pangaea… panmd   9017…        1 2020-01-17T15:1… <NA>                          2   Vuilleumier Lau…               NA <chr [51]>       <chr [6]>                       3
#>  6 pangaea… panmd   9017…        1 2020-01-17T15:1… https://doi.pan…              0.3 Peeken Ilka#Mur…           901742 <chr [101]>      <chr [6]>                       3
#>  7 pangaea… panmd   9017…        1 2020-01-17T15:1… <NA>                         NA   Schreuder Laura…               NA <chr [37]>       <chr [3]>                       1
#>  8 pangaea… panmd   9017…        1 2020-01-17T15:1… https://doi.org…              0   Schreuder Laura…           901739 <chr [39]>       <chr [7]>                       1
#>  9 pangaea… panmd   9016…        1 2020-01-17T15:1… <NA>                         10   Augustine John$…               NA <chr [25]>       <chr [6]>                       3
#> 10 pangaea… panmd   9016…        1 2020-01-17T15:1… <NA>                          2   Augustine John$…               NA <chr [29]>       <chr [6]>                       3
#> # … with 34 more variables: `_source.agg-campaign` <list>, `_source.agg-author` <list>, `_source.eastBoundLongitude` <dbl>, `_source.URI` <chr>, `_source.agg-pubYear` <int>,
#> #   `_source.minDateTime` <chr>, `_source.agg-geometry` <chr>, `_source.xml-thumb` <chr>, `_source.xml` <chr>, `_source.sf-idDataSet` <int>, `_source.elevationGeocode` <chr>,
#> #   `_source.agg-method` <list>, `_source.maxDateTime` <chr>, `_source.xml-sitemap` <chr>, `_source.westBoundLongitude` <dbl>, `_source.northBoundLatitude` <dbl>,
#> #   `_source.sp-dataStatus` <int>, `_source.nDataPoints` <int>, `_source.sp-hidden` <lgl>, `_source.agg-location` <list>, `_source.internal-source` <chr>,
#> #   `_source.agg-basis` <chr>, `_source.southBoundLatitude` <dbl>, `_source.boost` <dbl>, `_source.oaiSet` <list>, `_source.maxElevation` <dbl>, `_source.agg-mainTopic` <list>,
#> #   `_source.agg-topic` <list>, `_source.agg-project` <list>, `_source.meanPosition.lat` <dbl>, `_source.meanPosition.lon` <dbl>, `_source.geoCoverage.type` <chr>,
#> #   `_source.geoCoverage.coordinates` <list>, `_source.geoCoverage.geometries` <list>
```

The returned data.frame has a lot of columns. You can limit columns returned with the `source` parameter.

There are attributes on the data.frame that give you the total number of results found as well as the max score found. 


```r
attributes(res)
```

```
#> $names
#>  [1] "_index"                          "_type"                           "_id"                             "_score"                          "_source.internal-datestamp"     
#>  [6] "_source.parentURI"               "_source.minElevation"            "_source.sf-authortitle"          "_source.parentIdDataSet"         "_source.techKeyword"            
#> [11] "_source.geocodes"                "_source.sp-loginOption"          "_source.agg-campaign"            "_source.agg-author"              "_source.eastBoundLongitude"     
#> [16] "_source.URI"                     "_source.agg-pubYear"             "_source.minDateTime"             "_source.agg-geometry"            "_source.xml-thumb"              
#> [21] "_source.xml"                     "_source.sf-idDataSet"            "_source.elevationGeocode"        "_source.agg-method"              "_source.maxDateTime"            
#> [26] "_source.xml-sitemap"             "_source.westBoundLongitude"      "_source.northBoundLatitude"      "_source.sp-dataStatus"           "_source.nDataPoints"            
#> [31] "_source.sp-hidden"               "_source.agg-location"            "_source.internal-source"         "_source.agg-basis"               "_source.southBoundLatitude"     
#> [36] "_source.boost"                   "_source.oaiSet"                  "_source.maxElevation"            "_source.agg-mainTopic"           "_source.agg-topic"              
#> [41] "_source.agg-project"             "_source.meanPosition.lat"        "_source.meanPosition.lon"        "_source.geoCoverage.type"        "_source.geoCoverage.coordinates"
#> [46] "_source.geoCoverage.geometries" 
#> 
#> $row.names
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> 
#> $class
#> [1] "tbl_df"     "tbl"        "data.frame"
#> 
#> $total
#> [1] 390620
#> 
#> $max_score
#> [1] 1
```

```r
attr(res, "total")
```

```
#> [1] 390620
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
#>  [1] "10.1594/PANGAEA.901810"                        "10.1594/PANGAEA.901736"                        "10.1594/PANGAEA.901733"                       
#>  [4] "10.1594/PANGAEA.901732"                        "https://doi.pangaea.de/10.1594/PANGAEA.901710" "https://doi.pangaea.de/10.1594/PANGAEA.901709"
#>  [7] "10.1594/PANGAEA.901739"                        "10.1594/PANGAEA.901738"                        "https://doi.pangaea.de/10.1594/PANGAEA.901697"
#> [10] "https://doi.pangaea.de/10.1594/PANGAEA.901695"
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
#>    Event       `Date/Time`    Latitude Longitude `Elevation [m]` `Depth water [m… `Press [dbar]` `Temp [°C]`   Sal `Tpot [°C]` `Sigma-theta [kg/m… `Sigma in situ [kg… `Cond [mS/cm]`
#>    <chr>       <chr>             <dbl>     <dbl>           <int>            <dbl>          <int>       <dbl> <dbl>       <dbl>               <dbl>               <dbl>          <dbl>
#>  1 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             0                 0        15.7  35.7        15.7                26.4                26.4           44.4
#>  2 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             0.99              1        15.7  35.7        15.7                26.4                26.4           44.4
#>  3 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             1.98              2        15.7  35.7        15.7                26.4                26.4           44.4
#>  4 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             2.97              3        15.7  35.7        15.7                26.4                26.4           44.4
#>  5 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             3.96              4        15.7  35.7        15.7                26.4                26.4           44.4
#>  6 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             4.96              5        15.7  35.7        15.7                26.4                26.4           44.4
#>  7 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             5.95              6        15.7  35.7        15.7                26.4                26.4           44.4
#>  8 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             6.94              7        15.7  35.7        15.7                26.4                26.4           44.4
#>  9 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             7.93              8        15.7  35.7        15.7                26.4                26.4           44.4
#> 10 M36/6-CTD-… 1996-10-14T12…     49.0     -16.5           -4802             8.92              9        15.7  35.7        15.7                26.4                26.4           44.4
#> # … with 32,169 more rows
```

Search for data then pass one or more DOIs to the `pg_data` function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
```

```
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.405695
#>   parent doi: 10.1594/PANGAEA.405695
#>   url:        https://doi.org/10.1594/PANGAEA.405695
#>   citation:   WOCE Surface Velocity Program, SVP (2006): Water temperature and current velocity from surface drifter SVP_9524470. PANGAEA, https://doi.org/10.1594/PANGAEA.405695
#>   path:       /Users/sckott/Library/Caches/R/pangaear/10_1594_PANGAEA_405695.txt
#>   data:
#> # A tibble: 192 x 10
#>    `Date/Time`      Latitude Longitude `Depth water [m]` `Temp [°C]` `UC [cm/s]` `VC [cm/s]` `Lat e` `Lon e`  Code
#>    <chr>               <dbl>     <dbl>             <int>       <dbl>       <dbl>       <dbl>   <dbl>   <dbl> <int>
#>  1 1995-12-21T18:00     42.9     -125.                 0        12.4       NA          NA     0.0001  0.0001     1
#>  2 1995-12-22T00:00     42.9     -125.                 0        12.4        4.24      -35.2   0       0          1
#>  3 1995-12-22T06:00     42.8     -125.                 0        12.4       -7.8       -38.7   0.0002  0.0001     1
#>  4 1995-12-22T12:00     42.7     -125.                 0        12.4      -12.7       -23.1   0.0001  0.0001     1
#>  5 1995-12-22T18:00     42.7     -125.                 0        12.4      -15.1       -13.7   0       0          1
#>  6 1995-12-23T00:00     42.7     -125.                 0        12.3      -24.1        -9.15  0.0001  0.0001     1
#>  7 1995-12-23T06:00     42.7     -125.                 0        12.3      -38.4         0.65  0.0001  0.0001     1
#>  8 1995-12-23T12:00     42.7     -125.                 0        12.3      -37.2        15.8   0       0          1
#>  9 1995-12-23T18:00     42.7     -125.                 0        12.3      -25.4        29.6   0.0001  0.0001     1
#> 10 1995-12-24T00:00     42.8     -125.                 0        12.4      -18.5        35.1   0.0002  0.0002     1
#> # … with 182 more rows
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
#>   metadataPrefix                                                  schema                           metadataNamespace
#> 1         oai_dc          http://www.openarchives.org/OAI/2.0/oai_dc.xsd http://www.openarchives.org/OAI/2.0/oai_dc/
#> 2         pan_md       http://ws.pangaea.de/schemas/pangaea/MetaData.xsd              http://www.pangaea.de/MetaData
#> 3            dif  http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/dif_v9.4.xsd  http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/
#> 4       iso19139                http://www.isotc211.org/2005/gmd/gmd.xsd            http://www.isotc211.org/2005/gmd
#> 5  iso19139.iodp                http://www.isotc211.org/2005/gmd/gmd.xsd            http://www.isotc211.org/2005/gmd
#> 6      datacite3   http://schema.datacite.org/meta/kernel-3/metadata.xsd         http://datacite.org/schema/kernel-3
#> 7      datacite4 http://schema.datacite.org/meta/kernel-4.1/metadata.xsd         http://datacite.org/schema/kernel-4
```

### List identifiers


```r
pg_list_identifiers(from = Sys.Date() - 2, until = Sys.Date())
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

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
```

```
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$header
#> # A tibble: 1 x 3
#>   identifier                                datestamp            setSpec                                           
#>   <chr>                                     <chr>                <chr>                                             
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2020-01-18T03:11:42Z citable;supplement;topicChemistry;topicLithosphere
#> 
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$metadata
#> # A tibble: 1 x 13
#>   title            creator     source                publisher date   type   format  identifier       description               language rights       coverage               subject 
#>   <chr>            <chr>       <chr>                 <chr>     <chr>  <chr>  <chr>   <chr>            <chr>                     <chr>    <chr>        <chr>                  <chr>   
#> 1 Trace metals in… Demina, Ly… P.P. Shirshov Instit… PANGAEA   2012-… Datas… applic… https://doi.pan… Bioaccumulation of trace… en       CC-BY-3.0: … MEDIAN LATITUDE: 29.1… Archive…
```
