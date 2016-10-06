pangaear
========



[![Build Status](https://travis-ci.org/ropensci/pangaear.svg?branch=master)](https://travis-ci.org/ropensci/pangaear)
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
#> # A tibble: 3 × 6
#>      score                    doi  size size_measure
#> *    <dbl>                  <chr> <dbl>        <chr>
#> 1 2.429901 10.1594/PANGAEA.736010     9     datasets
#> 2 2.367171 10.1594/PANGAEA.812094     2     datasets
#> 3 2.093661 10.1594/PANGAEA.863080   171  data points
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
pg_data(res$doi[3])
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.863080
#> # A tibble: 19 × 15
#>              Event Latitude Longitude `Elevation [m]`           Device
#>              <chr>    <dbl>     <dbl>           <int>            <chr>
#> 1          CHA-248  37.6833 -177.0667           -5304        Trawl net
#> 2          CHA-252  37.8667 -160.2833           -4499             Grab
#> 3          CHA-285 -32.6000 -137.7167           -3900             Grab
#> 4          SJE-910  22.0003 -114.1000           -4000           Dredge
#> 5           BAC-56  22.8367 -109.5583           -1700           Dredge
#> 6        MV65-1-38  24.4003 -113.2667           -1950           Dredge
#> 7        BLAKE-317  31.9500  -78.3097            -640           Dredge
#> 8        BLAKE-317  31.9500  -78.3097            -640           Dredge
#> 9      HUD67/19-54  39.0000  -60.9500           -1700           Dredge
#> 10     HUD67/19-54  39.0000  -60.9500           -1700           Dredge
#> 11           D4799  26.0670  -22.3670            2300           Dredge
#> 12       MABAH-166   6.9167   67.1833           -4793 Monegasque Trawl
#> 13       MABAH-166   6.9167   67.1833           -4793 Monegasque Trawl
#> 14       MABAH-166   6.9167   67.1833           -4793 Monegasque Trawl
#> 15     Loch_Fyne_B  55.8433   -5.3283            -190             Grab
#> 16          JVIN_G  50.1033 -123.7933            -338           Dredge
#> 17 Lake_LillaUlv_S  59.5821   17.5399               4
#> 18    Noil_Tobee_M  -9.7672  124.5312             480
#> 19       Saline_MO  39.2695  -93.2708             197
#> # ... with 10 more variables: ID <chr>, Label <chr>, `Depth [m]` <int>,
#> #   `Mn [%]` <dbl>, `Fe [%]` <dbl>, `Co [%]` <dbl>, `Ni [%]` <dbl>, `Cu
#> #   [%]` <dbl>, `Sn [mg/kg]` <dbl>, Description <chr>
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
#> <ListRecords> 59065 X 7
#>
#>                                   identifier            datestamp setSpec
#> 1  oai:pangaea.de:doi:10.1594/PANGAEA.111526 2016-10-04T08:35:04Z      NA
#> 2  oai:pangaea.de:doi:10.1594/PANGAEA.111527 2016-10-04T08:35:04Z      NA
#> 3  oai:pangaea.de:doi:10.1594/PANGAEA.111528 2016-10-04T08:35:05Z      NA
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.111529 2016-10-04T08:35:05Z      NA
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.111560 2016-10-04T08:35:12Z      NA
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.111561 2016-10-04T08:35:13Z      NA
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.111562 2016-10-04T08:35:13Z      NA
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.111510 2016-10-04T08:35:00Z      NA
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.111511 2016-10-04T08:35:01Z      NA
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.111512 2016-10-04T08:35:01Z      NA
#> ..                                       ...                  ...     ...
#> Variables not shown: setSpec.1 (chr), setSpec.2 (chr), setSpec.3 (chr),
#>      setSpec.4 (chr)
```

### List sets


```r
pg_list_sets()
#> <ListSets> 236 X 2
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
pg_list_records(from = Sys.Date() - 1, until = Sys.Date())
#> <ListRecords> 973 X 584
#>
#>                                   identifier            datestamp
#> 1  oai:pangaea.de:doi:10.1594/PANGAEA.841123 2016-10-05T07:54:00Z
#> 2  oai:pangaea.de:doi:10.1594/PANGAEA.841124 2016-10-05T07:54:00Z
#> 3  oai:pangaea.de:doi:10.1594/PANGAEA.858057 2016-10-05T07:38:36Z
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.864346 2016-10-05T06:15:52Z
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.864352 2016-10-05T06:16:00Z
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.864348 2016-10-05T06:15:54Z
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.864351 2016-10-05T06:15:59Z
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.836114 2016-10-05T08:29:21Z
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.865195 2016-10-05T08:29:21Z
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.861354 2016-10-05T08:24:54Z
#> ..                                       ...                  ...
#> Variables not shown: title (chr), creator (chr), source (chr), publisher
#>      (chr), date (chr), type (chr), format (chr), identifier.2 (chr),
#>      identifier.1 (chr), language (chr), rights (chr), rights.1 (chr),
#>      relation (chr), relation.1 (chr), coverage (chr), subject (chr),
#>      setSpec (chr), setSpec.1 (chr), creator.1 (chr), creator.2 (chr),
#>      creator.3 (chr), description (chr), creator.4 (chr), creator.5 (chr),
#>      creator.6 (chr), creator.7 (chr), setSpec.2 (chr), creator.8 (chr),
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> <GetRecord> 1 X 23
#>
#>                                  identifier            datestamp setSpec
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2016-06-25T14:58:45Z citable
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
