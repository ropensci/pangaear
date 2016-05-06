pangaear
========



[![Build Status](https://api.travis-ci.org/ropensci/pangaear.png)](https://travis-ci.org/ropensci/pangaear)
[![Build status](https://ci.appveyor.com/api/projects/status/564oioj2oyefax08?svg=true)](https://ci.appveyor.com/project/sckott/pangaear)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/pangaear)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/pangaear)](https://cran.r-project.org/package=pangaear)

An R client to interact with the [Pangaea database](http://www.pangaea.de/).

## Info

* Pangaea [website](http://www.pangaea.de/).
* Pangaea [OAI-PMH docs](http://wiki.pangaea.de/wiki/OAI-PMH).
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
pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1), count=3)
#> Source: local data frame [3 x 5]
#> 
#>                                             doi score_per size_datasets
#>                                           <chr>     <chr>         <chr>
#> 1 https://doi.pangaea.de/10.1594/PANGAEA.736010      2.38             9
#> 2 https://doi.pangaea.de/10.1594/PANGAEA.812094      2.24             2
#> 3 https://doi.pangaea.de/10.1594/PANGAEA.803591      2.02             2
#> Variables not shown: citation <chr>, supplement_to <chr>.
```

## Get data


```r
res <- pg_data(doi='10.1594/PANGAEA.807580')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.807580
#>                Event        Date/Time Latitude Longitude Elevation [m]
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
#> Variables not shown: Depth water [m] (dbl), Press [dbar] (int), Temp [°C]
#>      (dbl), Sal (dbl), Tpot [°C] (dbl), Sigma-theta [kg/m**3] (dbl), Sigma
#>      in situ [kg/m**3] (dbl), Cond [mS/cm] (dbl)
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1), count=3)
pg_data(res$doi[3])
#> Error in pang_GET(bp = path, url = paste0(base(), x), doi = x, overwrite): Not Found (HTTP 404).
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

## Contributors (alphabetical)

* Scott Chamberlain
* Andrew MacDonald
* Gavin Simpson
* Kara Woo
* Naupaka Zimmerman

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/pangaear/issues).
* License: MIT
* Get citation information for `pangaear` in R doing `citation(package = 'pangaear')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![ro_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
