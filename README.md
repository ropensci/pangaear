pangaear
========



[![Build Status](https://api.travis-ci.org/ropensci/pangaear.png)](https://travis-ci.org/ropensci/pangaear)
[![Build status](https://ci.appveyor.com/api/projects/status/564oioj2oyefax08?svg=true)](https://ci.appveyor.com/project/sckott/pangaear)
[![codecov](https://codecov.io/gh/ropensci/pangaear/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/pangaear)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/pangaear)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/pangaear)](https://cran.r-project.org/package=pangaear)

An R client to interact with the [Pangaea database](https://www.pangaea.de/).

## Info

* Pangaea [website](https://www.pangaea.de/).
* Pangaea [OAI-PMH docs](https://wiki.pangaea.de/wiki/OAI-PMH).
* [OAI-PMH Spec](http://www.openarchives.org/OAI/openarchivesprotocol.html)

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
#> Source: local data frame [3 x 5]
#> 
#>                      doi score size_datasets
#>                    <chr> <dbl>         <dbl>
#> 1 10.1594/PANGAEA.736010  2.38             9
#> 2 10.1594/PANGAEA.812094  2.24             2
#> 3 10.1594/PANGAEA.803591  2.02             2
#> Variables not shown: citation <chr>, supplement_to <chr>.
```

## Get data


```r
res <- pg_data(doi = '10.1594/PANGAEA.807580')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.807580
#> Source: local data frame [32,179 x 13]
#> 
#>                Event        Date/Time Latitude Longitude Elevation [m]
#>                <chr>            <chr>    <dbl>     <dbl>         <int>
#> 1  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 2  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 3  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 4  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 5  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 6  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 7  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 8  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 9  M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> 10 M36/6-CTD-365_003 1996-10-14T12:24  48.9667  -16.4633         -4802
#> ..               ...              ...      ...       ...           ...
#> Variables not shown: Depth water [m] <dbl>, Press [dbar] <int>, Temp [°C]
#>   <dbl>, Sal <dbl>, Tpot [°C] <dbl>, Sigma-theta [kg/m**3] <dbl>, Sigma in
#>   situ [kg/m**3] <dbl>, Cond [mS/cm] <dbl>.
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query = 'water', bbox = c(-124.2, 41.8, -116.8, 46.1), count = 3)
pg_data(res$doi[3])
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.803588
#> Source: local data frame [24 x 21]
#> 
#>       Event Latitude Longitude Elevation [m]          Label   Samp type
#>       <chr>    <dbl>     <dbl>         <int>          <chr>       <chr>
#> 1  164-994A  31.7857  -75.5459         -2798 164-994A-30X-5    Gas tube
#> 2  164-994A  31.7857  -75.5459         -2798 164-994A-31X-5    Gas tube
#> 3  164-994C  31.7857  -75.5459         -2799 164-994C-31X-3    Free gas
#> 4  164-994C  31.7857  -75.5459         -2799 164-994C-31X-7 Hydrate gas
#> 5  164-996A  32.4939  -76.1909         -2170  164-996A-1H-1 Hydrate gas
#> 6  164-996A  32.4939  -76.1909         -2170  164-996A-8H-3    Free gas
#> 7  164-996A  32.4939  -76.1909         -2170  164-996A-8H-4 Hydrate gas
#> 8  164-996A  32.4939  -76.1909         -2170  164-996A-8H-5    Free gas
#> 9  164-996A  32.4939  -76.1909         -2170 164-996A-9H-CC Hydrate gas
#> 10 164-996B  32.4939  -76.1909         -2173  164-996B-1H-1 Hydrate gas
#> ..      ...      ...       ...           ...            ...         ...
#> Variables not shown: Depth [m] <dbl>, V/V (gas/water) <int>, V/V
#>   (gas/water, chlorinity corrected) <int>, cl [mmol/l] <int>, CH4 [%]
#>   <dbl>, C2H6 [ppmv] <int>, C3H8 [ppmv] <dbl>, i-C4H10 [ppmv] <dbl>,
#>   n-C4H10 [ppmv] <dbl>, CO2 [%] <dbl>, C1/(C2+C3) <int>, d13C CH4 [per mil
#>   PDB] <dbl>, dD CH4 [per mil] <dbl>, d13C CO2 GH [per mil PDB] <dbl>, dD
#>   H2O [per mil SMOW] <dbl>.
#> 
#> [[2]]
#> <Pangaea data> 10.1594/PANGAEA.803590
#> Source: local data frame [14 x 12]
#> 
#>          Event Latitude Longitude Elevation [m]                      Area
#>          <chr>    <dbl>     <dbl>         <int>                     <chr>
#> 1      76-533A  31.2600  -74.8698         -3191               Blake Ridge
#> 2  84-565_Site   9.7282  -86.0907         -3099     Middle America Trench
#> 3  84-568_Site  13.0722  -90.8000         -2010       Offshore Costa Rica
#> 4  84-568_Site  13.0722  -90.8000         -2010       Offshore Costa Rica
#> 5  84-570_Site  13.2853  -91.3928         -1698       Offshore Costa Rica
#> 6  84-570_Site  13.2853  -91.3928         -1698       Offshore Costa Rica
#> 7  84-570_Site  13.2853  -91.3928         -1698       Offshore Costa Rica
#> 8  84-570_Site  13.2853  -91.3928         -1698       Offshore Costa Rica
#> 9  84-570_Site  13.2853  -91.3928         -1698       Offshore Costa Rica
#> 10    112-685A  -9.1130  -80.5835         -5093             Offshore Peru
#> 11    112-688A -11.5377  -78.9428         -3827             Offshore Peru
#> 12    112-688A -11.5377  -78.9428         -3827             Offshore Peru
#> 13    146-892D  44.6740 -125.1190          -686 Cascadia, offshore Oregon
#> 14    146-892D  44.6740 -125.1190          -686 Cascadia, offshore Oregon
#> Variables not shown: Depth [m] <dbl>, Depth top [m] <int>, Depth bot [m]
#>   <int>, V/V (gas/water; # = 24-42) <chr>, V/V (gas/water, chlorinity
#>   correct...) <chr>, cl [mmol/l] <dbl>, Reference <chr>.
```

## OAI-PMH metadata

### Identify the service


```r
pg_identify()
#> <Pangaea>
#>   repositoryName: PANGAEA - Data Publisher for Earth & Environmental Science
#>   baseURL: http://ws.pangaea.de/oai/provider
#>   protocolVersion: 2.0
#>   adminEmail: tech@pangaea.de
#>   adminEmail: tech@pangaea.de
#>   earliestDatestamp: 2015-01-01T00:00:00Z
#>   deletedRecord: transient
#>   granularity: YYYY-MM-DDThh:mm:ssZ
#>   compression: gzip
#>   description: 
#> 
#> oai
#> pangaea.de
#> :
#> oai:pangaea.de:doi:10.1594/PANGAEA.999999
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
pg_list_identifiers(from = '2015-09-01', until = '2015-09-05')
#> <ListRecords> 244 X 5 
#> 
#>                                   identifier            datestamp
#> 1  oai:pangaea.de:doi:10.1594/PANGAEA.131638 2015-09-01T20:36:34Z
#> 2  oai:pangaea.de:doi:10.1594/PANGAEA.183530 2015-09-01T20:37:49Z
#> 3  oai:pangaea.de:doi:10.1594/PANGAEA.138509 2015-09-01T20:37:42Z
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.354765 2015-09-01T20:35:30Z
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.763664 2015-09-01T20:49:23Z
#> 6   oai:pangaea.de:doi:10.1594/PANGAEA.66910 2015-09-01T20:37:00Z
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.759867 2015-09-01T20:48:55Z
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.183545 2015-09-01T20:37:51Z
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.712451 2015-09-01T20:45:25Z
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.788012 2015-09-01T08:22:36Z
#> ..                                       ...                  ...
#> Variables not shown: setSpec (chr), setSpec.1 (chr), setSpec.2 (chr)
```

### List sets


```r
pg_list_sets()
#> <ListSets> 233 X 2 
#> 
#>         setSpec
#> 1    projectXXX
#> 2     authorXXX
#> 3         piXXX
#> 4    journalXXX
#> 5      basisXXX
#> 6   campaignXXX
#> 7     deviceXXX
#> 8    geocodeXXX
#> 9  query~BASE64
#> 10          ACD
#> ..          ...
#> Variables not shown: setName (chr)
```

### List records


```r
pg_list_records(from = '2015-09-01', until = '2015-09-10')
#> <ListRecords> 274 X 36 
#> 
#>                                   identifier            datestamp
#> 1  oai:pangaea.de:doi:10.1594/PANGAEA.131638 2015-09-01T20:36:34Z
#> 2  oai:pangaea.de:doi:10.1594/PANGAEA.183530 2015-09-01T20:37:49Z
#> 3  oai:pangaea.de:doi:10.1594/PANGAEA.138509 2015-09-01T20:37:42Z
#> 4   oai:pangaea.de:doi:10.1594/PANGAEA.57294 2015-09-08T08:26:51Z
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.354765 2015-09-01T20:35:30Z
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.763664 2015-09-01T20:49:23Z
#> 7   oai:pangaea.de:doi:10.1594/PANGAEA.66910 2015-09-01T20:37:00Z
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.759867 2015-09-01T20:48:55Z
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.183545 2015-09-01T20:37:51Z
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.712451 2015-09-01T20:45:25Z
#> ..                                       ...                  ...
#> Variables not shown: title (chr), creator (chr), publisher (chr), date
#>      (chr), type (chr), format (chr), identifier.2 (chr), identifier.1
#>      (chr), language (chr), rights (chr), rights.1 (chr), relation (chr),
#>      coverage (chr), subject (chr), setSpec (chr), relation.1 (chr),
#>      creator.1 (chr), creator.2 (chr), source (chr), setSpec.1 (chr),
#>      setSpec.2 (chr), description (chr), creator.3 (chr), creator.4 (chr),
#>      creator.5 (chr), creator.6 (chr), creator.7 (chr), creator.8 (chr),
#>      creator.9 (chr), creator.10 (chr), source.1 (chr), relation.2 (chr),
#>      relation.3 (chr), relation.4 (chr)
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> <GetRecord> 1 X 23 
#> 
#>                                  identifier            datestamp setSpec
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2015-04-12T02:47:43Z citable
#> Variables not shown: setSpec.1 (chr), setSpec.2 (chr), title (chr),
#>      creator (chr), creator.1 (chr), creator.2 (chr), source (chr),
#>      source.1 (chr), publisher (chr), date (chr), type (chr), format
#>      (chr), identifier.2 (chr), identifier.1 (chr), description (chr),
#>      language (chr), rights (chr), rights.1 (chr), coverage (chr), subject
#>      (chr)
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

[![ro_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
