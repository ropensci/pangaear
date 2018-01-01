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
#>   score doi                       size size_measure citation  supplement_…
#>   <dbl> <chr>                    <dbl> <chr>        <chr>     <chr>       
#> 1  20.0 10.1594/PANGAEA.812094    2.00 datasets     Simonyan… Simonyan, A…
#> 2  11.0 10.1594/PANGAEA.736010    9.00 datasets     Archer, … Archer, DE;…
#> 3  10.9 10.1594/PANGAEA.874893 4152    data points  Uhlig, C… Uhlig, C; L…
```

The resulting `data.frame` has details about different studies, and you can use the DOIs (Digital Object Identifiers) to get data and metadata for any studies you're interested in.

### Another search option

There's another search option with the `pg_search_es` function. It is an interface to the Pangaea Elasticsearch interface. This provides a very flexible interface for search Pangaea data - though it is different from what you're used to with the Pangaea website. 


```r
(res <- pg_search_es())
```

```
#> # A tibble: 10 x 42
#>    `_ind… `_typ… `_id` `_sc… `_so… `_sour… `_sour… `_so… `_so… `_so… `_so…
#>  * <chr>  <chr>  <chr> <dbl> <chr>   <dbl> <chr>   <lis> <lis> <int> <chr>
#>  1 panga… panmd  7847…  1.00 2017… 5.00e⁻¹ Owens … <chr… <chr…     1 D203A
#>  2 panga… panmd  8453…  1.00 2017… 1.10e⁺¹ Maturi… <chr… <chr…     3 WCRP…
#>  3 panga… panmd  3806…  1.00 2017… 1.00e⁺¹ König-… <chr… <chr…     1 ANT-…
#>  4 panga… panmd  8467…  1.00 2017… 2.00e⁺⁰ Colle … <chr… <chr…     3 WCRP…
#>  5 panga… panmd  8467…  1.00 2017… 2.00e⁺⁰ Denn F… <chr… <chr…     3 WCRP…
#>  6 panga… panmd  7077…  1.00 2017… 4.91e⁺² Vuille… <chr… <chr…     3 WCRP…
#>  7 panga… panmd  67642  1.00 2017… 1.00e⁻² Hebbel… <chr… <chr…     1 SO15…
#>  8 panga… panmd  8373…  1.00 2017… 1.39e⁺⁰ WOCE H… <chr… <chr…     1 33KM…
#>  9 panga… panmd  8469…  1.00 2017… 2.00e⁺⁰ Long C… <chr… <chr…     3 WCRP…
#> 10 panga… panmd  8469…  1.00 2017… 2.00e⁺⁰ Tamlyn… <chr… <chr…     3 WCRP…
#> # ... with 31 more variables: `_source.agg-author` <list>,
#> #   `_source.eastBoundLongitude` <dbl>, `_source.URI` <chr>,
#> #   `_source.agg-pubYear` <int>, `_source.minDateTime` <chr>,
#> #   `_source.agg-geometry` <chr>, `_source.xml-thumb` <chr>,
#> #   `_source.agg-mainTopic` <list>, `_source.xml` <chr>,
#> #   `_source.elevationGeocode` <chr>, `_source.maxDateTime` <chr>,
#> #   `_source.xml-sitemap` <chr>, `_source.agg-topic` <list>,
#> #   `_source.westBoundLongitude` <dbl>, `_source.agg-project` <chr>,
#> #   `_source.northBoundLatitude` <dbl>, `_source.sp-dataStatus` <int>,
#> #   `_source.sp-hidden` <lgl>, `_source.agg-location` <list>,
#> #   `_source.internal-source` <chr>, `_source.agg-basis` <chr>,
#> #   `_source.southBoundLatitude` <dbl>, `_source.idDataSet` <int>,
#> #   `_source.boost` <dbl>, `_source.agg-device` <chr>,
#> #   `_source.maxElevation` <dbl>, `_source.parentURI` <chr>,
#> #   `_source.parentIdDataSet` <int>, `_source.oaiSet` <chr>,
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
#> [11] "_source.agg-campaign"       "_source.agg-author"        
#> [13] "_source.eastBoundLongitude" "_source.URI"               
#> [15] "_source.agg-pubYear"        "_source.minDateTime"       
#> [17] "_source.agg-geometry"       "_source.xml-thumb"         
#> [19] "_source.agg-mainTopic"      "_source.xml"               
#> [21] "_source.elevationGeocode"   "_source.maxDateTime"       
#> [23] "_source.xml-sitemap"        "_source.agg-topic"         
#> [25] "_source.westBoundLongitude" "_source.agg-project"       
#> [27] "_source.northBoundLatitude" "_source.sp-dataStatus"     
#> [29] "_source.sp-hidden"          "_source.agg-location"      
#> [31] "_source.internal-source"    "_source.agg-basis"         
#> [33] "_source.southBoundLatitude" "_source.idDataSet"         
#> [35] "_source.boost"              "_source.agg-device"        
#> [37] "_source.maxElevation"       "_source.parentURI"         
#> [39] "_source.parentIdDataSet"    "_source.oaiSet"            
#> [41] "_source.meanPosition.lat"   "_source.meanPosition.lon"  
#> 
#> $row.names
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> 
#> $class
#> [1] "tbl_df"     "tbl"        "data.frame"
#> 
#> $total
#> [1] 370634
#> 
#> $max_score
#> [1] 1
```

```r
attr(res, "total")
```

```
#> [1] 370634
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
#>  [1] "10.1594/PANGAEA.784764" "10.1594/PANGAEA.845354"
#>  [3] "10.1594/PANGAEA.380654" "10.1594/PANGAEA.846724"
#>  [5] "10.1594/PANGAEA.846729" "10.1594/PANGAEA.707787"
#>  [7] "10.1594/PANGAEA.67642"  "10.1594/PANGAEA.837347"
#>  [9] "10.1594/PANGAEA.846977" "10.1594/PANGAEA.846979"
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

Search for data then pass one or more DOIs to the `pg_data` function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])[1:3]
```

```
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
```

```
#> # A tibble: 390 x 6
#>    identifier                                date… setS… setS… setS… setS…
#>    <chr>                                     <chr> <chr> <chr> <chr> <chr>
#>  1 oai:pangaea.de:doi:10.1594/PANGAEA.870867 2017… cita… cita… supp… <NA> 
#>  2 oai:pangaea.de:doi:10.1594/PANGAEA.724540 2017… cita… cita… supp… <NA> 
#>  3 oai:pangaea.de:doi:10.1594/PANGAEA.149999 2017… cita… cita… supp… <NA> 
#>  4 oai:pangaea.de:doi:10.1594/PANGAEA.816714 2017… cita… cita… deNB… supp…
#>  5 oai:pangaea.de:doi:10.1594/PANGAEA.817715 2017… cita… cita… deNB… supp…
#>  6 oai:pangaea.de:doi:10.1594/PANGAEA.819855 2017… cita… cita… <NA>  <NA> 
#>  7 oai:pangaea.de:doi:10.1594/PANGAEA.820004 2017… cita… cita… supp… <NA> 
#>  8 oai:pangaea.de:doi:10.1594/PANGAEA.858878 2017… cita… cita… deNB… supp…
#>  9 oai:pangaea.de:doi:10.1594/PANGAEA.880113 2017… cita… cita… supp… <NA> 
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.884462 2017… cita… cita… supp… <NA> 
#> # ... with 380 more rows
```

### List sets


```r
pg_list_sets()
```

```
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
```

```
#> # A tibble: 44 x 37
#>    iden… date… setS… setS… setS… setS… title crea… crea… crea… crea… crea…
#>    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 oai:… 2017… cita… cita… deNB… supp… Geoc… Pirr… Händ… Mert… Enge… Pudl…
#>  2 oai:… 2018… cita… cita… supp… <NA>  Mult… Bart… Tits… Fahl… Stei… Seid…
#>  3 oai:… 2018… supp… <NA>  <NA>  <NA>  Hous… Teys… Rouf… Sale… Stru… Matt…
#>  4 oai:… 2017… deNB… supp… <NA>  <NA>  Biom… Rama… Marb… Prad… Pero… Lard…
#>  5 oai:… 2017… supp… <NA>  <NA>  <NA>  Cont… Welc… Mund… <NA>  <NA>  <NA> 
#>  6 oai:… 2018… <NA>  <NA>  <NA>  <NA>  Pore… Paul… Kosc… <NA>  <NA>  <NA> 
#>  7 oai:… 2018… <NA>  <NA>  <NA>  <NA>  Mete… Olef… <NA>  <NA>  <NA>  <NA> 
#>  8 oai:… 2018… <NA>  <NA>  <NA>  <NA>  Mete… Olef… <NA>  <NA>  <NA>  <NA> 
#>  9 oai:… 2018… <NA>  <NA>  <NA>  <NA>  Basi… Olef… <NA>  <NA>  <NA>  <NA> 
#> 10 oai:… 2018… <NA>  <NA>  <NA>  <NA>  Mete… Olef… <NA>  <NA>  <NA>  <NA> 
#> # ... with 34 more rows, and 25 more variables: creator.5 <chr>, creator.6
#> #   <chr>, source <chr>, publisher <chr>, date <chr>, type <chr>, format
#> #   <chr>, identifier.2 <chr>, identifier.1 <chr>, description <chr>,
#> #   language <chr>, rights <chr>, rights.1 <chr>, coverage <chr>, subject
#> #   <chr>, creator.7 <chr>, creator.8 <chr>, relation <chr>, creator.9
#> #   <chr>, creator.10 <chr>, creator.11 <chr>, relation.1 <chr>,
#> #   relation.2 <chr>, relation.3 <chr>, relation.4 <chr>
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
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2017-08-08T17:50:18Z citable;…
#> 
#> $`oai:pangaea.de:doi:10.1594/PANGAEA.788382`$metadata
#> # A tibble: 1 x 13
#>   title  crea… sour… publ… date  type  form… iden… desc… lang… righ… cove…
#>   <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#> 1 Trace… Demi… P.P.… PANG… 2012… Data… appl… http… Bioa… en    CC-B… MEDI…
#> # ... with 1 more variable: subject <chr>
```
