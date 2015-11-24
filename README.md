pangaear
========



[![Build Status](https://api.travis-ci.org/ropensci/pangaear.png)](https://travis-ci.org/ropensci/pangaear)
[![Build status](https://ci.appveyor.com/api/projects/status/564oioj2oyefax08?svg=true)](https://ci.appveyor.com/project/sckott/pangaear)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/pangaear)](https://github.com/metacran/cranlogs.app)

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
#>                      doi score_per size_datasets
#> 1 10.1594/PANGAEA.736010        NA             9
#> 2 10.1594/PANGAEA.812094        NA             2
#> 3 10.1594/PANGAEA.803591        NA             2
#>                                                                                                                          citation
#> 1                                           Archer, DE; Devol, AH (1992): Benthic oxygen flixes on the Washington shelf and slope
#> 2                                              Simonyan, AV; Dultz, S; Behrens, H (2012): Diffusion transport of water in basalts
#> 3 Lorenson, TD; Collett, TS (2000): Gas content, composition of gas hydrate and volumetric gas/water ratios of ODP and DSDP sites
#>                                                                                                                                                                                                                                                                                                                supplement_to
#> 1                                                                                                                                    Archer, DE; Devol, AH (1992): Benthic oxygen fluxes on the Washington shelf and slope: A comparison of in situ microelectrode and chamber flux measurements. Limnology and Oceanography
#> 2                                                                                                                                                                               Simonyan, AV; Dultz, S; Behrens, H (2012): Diffusive transport of water in porous fresh to altered mid-ocean ridge basalts. Chemical Geology
#> 3 Lorenson, TD; Collett, TS (2000): Gas content and composition of gas hydrate from sediments of the southeastern North American continental margin. In: Paull, CK; Matsumoto, R; Wallace, PJ; Dillon, WP (eds.) Proceedings of the Ocean Drilling Program, Scientific Results, College Station, TX (Ocean Drilling Program)
#>   related_to
#> 1         NA
#> 2         NA
#> 3         NA
```

## Get data


```r
res <- pg_data(doi='10.1594/PANGAEA.761032')
res[[1]]
#> <Pangaea data> 10.1594/PANGAEA.761002
#>          Event        Date/Time Latitude Longitude Elevation [m]
#> 1  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 2  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 3  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 4  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 5  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 6  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 7  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 8  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 9  NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> 10 NBP97-05/01 1997-08-04T12:09 -57.5007  -44.9915         -3090
#> ..         ...              ...      ...       ...           ...
#> Variables not shown: Depth water [m] (int), Temp [°C] (dbl), Sal (dbl),
#>      Tpot [°C] (dbl)
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1), count=3)
pg_data(res$doi[3])
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.803588
#>       Event Latitude Longitude Elevation [m] Sample code/label   Samp type
#> 1  164-994A  31.7857  -75.5459         -2798    164-994A-30X-5    Gas tube
#> 2  164-994A  31.7857  -75.5459         -2798    164-994A-31X-5    Gas tube
#> 3  164-994C  31.7857  -75.5459         -2799    164-994C-31X-3    Free gas
#> 4  164-994C  31.7857  -75.5459         -2799    164-994C-31X-7 Hydrate gas
#> 5  164-996A  32.4939  -76.1909         -2170     164-996A-1H-1 Hydrate gas
#> 6  164-996A  32.4939  -76.1909         -2170     164-996A-8H-3    Free gas
#> 7  164-996A  32.4939  -76.1909         -2170     164-996A-8H-4 Hydrate gas
#> 8  164-996A  32.4939  -76.1909         -2170     164-996A-8H-5    Free gas
#> 9  164-996A  32.4939  -76.1909         -2170    164-996A-9H-CC Hydrate gas
#> 10 164-996B  32.4939  -76.1909         -2173     164-996B-1H-1 Hydrate gas
#> ..      ...      ...       ...           ...               ...         ...
#> Variables not shown: Depth [m] (dbl), V/V (gas/water) (int), V/V
#>      (gas/water, chlorinity corrected) (int), cl [mmol/l] (int), CH4 [%]
#>      (dbl), C2H6 [ppmv] (int), C3H8 [ppmv] (dbl), i-C4H10 [ppmv] (dbl),
#>      n-C4H10 [ppmv] (dbl), CO2 [%] (dbl), C1/(C2+C3) (int), d13C CH4 [per
#>      mil PDB] (dbl), d2H CH4 [per mil] (dbl), d13C CO2 GH [per mil PDB]
#>      (dbl), d2H H2O [per mil SMOW] (dbl)
#> 
#> [[2]]
#> <Pangaea data> 10.1594/PANGAEA.803590
#>          Event Latitude Longitude Elevation [m]                  Area
#> 1      76-533A  31.2600  -74.8698         -3191           Blake Ridge
#> 2  84-565_Site   9.7282  -86.0907         -3099 Middle America Trench
#> 3  84-568_Site  13.0722  -90.8000         -2010   Offshore Costa Rica
#> 4  84-568_Site  13.0722  -90.8000         -2010   Offshore Costa Rica
#> 5  84-570_Site  13.2853  -91.3928         -1698   Offshore Costa Rica
#> 6  84-570_Site  13.2853  -91.3928         -1698   Offshore Costa Rica
#> 7  84-570_Site  13.2853  -91.3928         -1698   Offshore Costa Rica
#> 8  84-570_Site  13.2853  -91.3928         -1698   Offshore Costa Rica
#> 9  84-570_Site  13.2853  -91.3928         -1698   Offshore Costa Rica
#> 10    112-685A  -9.1130  -80.5835         -5093         Offshore Peru
#> ..         ...      ...       ...           ...                   ...
#> Variables not shown: Depth [m] (dbl), Depth top [m] (int), Depth bot [m]
#>      (int), V/V (gas/water; # = 24-42) (chr), V/V (gas/water, chlorinity
#>      correct...) (chr), cl [mmol/l] (dbl), Reference (chr)
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
#> <ListRecords> 558 X 4 
#> 
#>                                   identifier            datestamp setSpec
#> 1  oai:pangaea.de:doi:10.1594/PANGAEA.184936 2015-09-01T20:37:55Z      NA
#> 2  oai:pangaea.de:doi:10.1594/PANGAEA.183555 2015-09-01T20:37:53Z      NA
#> 3  oai:pangaea.de:doi:10.1594/PANGAEA.185032 2015-09-01T20:37:55Z      NA
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.183548 2015-09-01T20:37:52Z      NA
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.839344 2015-09-03T11:13:36Z      NA
#> 6   oai:pangaea.de:doi:10.1594/PANGAEA.55971 2015-09-01T20:36:44Z  ORFOIS
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.785469 2015-09-02T13:57:49Z    BCCR
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.829952 2015-09-01T20:56:03Z      NA
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.762358 2015-09-02T13:59:34Z      NA
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.848610 2015-09-03T03:04:29Z      NA
#> ..                                       ...                  ...     ...
#> Variables not shown: setSpec.1 (chr)
```

### List sets


```r
pg_list_sets()
#> <ListSets> 224 X 2 
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
#> <ListRecords> 763 X 95 
#> 
#>                                   identifier            datestamp
#> 1  oai:pangaea.de:doi:10.1594/PANGAEA.184936 2015-09-01T20:37:55Z
#> 2  oai:pangaea.de:doi:10.1594/PANGAEA.183555 2015-09-01T20:37:53Z
#> 3  oai:pangaea.de:doi:10.1594/PANGAEA.185032 2015-09-01T20:37:55Z
#> 4  oai:pangaea.de:doi:10.1594/PANGAEA.183548 2015-09-01T20:37:52Z
#> 5  oai:pangaea.de:doi:10.1594/PANGAEA.839344 2015-09-03T11:13:36Z
#> 6  oai:pangaea.de:doi:10.1594/PANGAEA.418297 2015-09-10T15:21:30Z
#> 7  oai:pangaea.de:doi:10.1594/PANGAEA.321210 2015-09-10T15:21:33Z
#> 8  oai:pangaea.de:doi:10.1594/PANGAEA.309957 2015-09-10T15:21:33Z
#> 9  oai:pangaea.de:doi:10.1594/PANGAEA.253597 2015-09-10T15:21:33Z
#> 10 oai:pangaea.de:doi:10.1594/PANGAEA.762169 2015-09-09T11:36:24Z
#> ..                                       ...                  ...
#> Variables not shown: title (chr), creator (chr), creator.1 (chr),
#>      creator.2 (chr), publisher (chr), date (chr), type (chr), format
#>      (chr), identifier.2 (chr), identifier.1 (chr), language (chr), rights
#>      (chr), rights.1 (chr), relation (chr), relation.1 (chr), coverage
#>      (chr), subject (chr), creator.3 (chr), source (chr), description
#>      (chr), setSpec (chr), setSpec.1 (chr), relation.2 (chr), creator.4
#>      (chr), creator.5 (chr), relation.3 (chr), creator.6 (chr), creator.7
#>      (chr), creator.8 (chr), creator.9 (chr), relation.4 (chr), relation.5
#>      (chr), relation.6 (chr), relation.7 (chr), relation.8 (chr),
#>      relation.9 (chr), relation.10 (chr), relation.11 (chr), relation.12
#>      (chr), relation.13 (chr), relation.14 (chr), relation.15 (chr),
#>      relation.16 (chr), relation.17 (chr), relation.18 (chr), relation.19
#>      (chr), relation.20 (chr), relation.21 (chr), relation.22 (chr),
#>      relation.23 (chr), relation.24 (chr), relation.25 (chr), relation.26
#>      (chr), relation.27 (chr), relation.28 (chr), relation.29 (chr),
#>      relation.30 (chr), relation.31 (chr), relation.32 (chr), relation.33
#>      (chr), relation.34 (chr), relation.35 (chr), relation.36 (chr),
#>      relation.37 (chr), relation.38 (chr), relation.39 (chr), relation.40
#>      (chr), source.1 (chr), creator.10 (chr), creator.11 (chr), creator.12
#>      (chr), creator.13 (chr), creator.14 (chr), creator.15 (chr),
#>      creator.16 (chr), creator.17 (chr), creator.18 (chr), creator.19
#>      (chr), creator.20 (chr), creator.21 (chr), creator.22 (chr),
#>      creator.23 (chr), creator.24 (chr), creator.25 (chr), creator.26
#>      (chr), creator.27 (chr), creator.28 (chr), creator.29 (chr),
#>      creator.30 (chr), creator.31 (chr), creator.32 (chr), creator.33
#>      (chr), creator.34 (chr)
```

### Get a record


```r
pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
#> <GetRecord> 1 X 20 
#> 
#>                                  identifier            datestamp
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.788382 2015-04-12T02:47:43Z
#> Variables not shown: title (chr), creator (chr), creator.1 (chr),
#>      creator.2 (chr), source (chr), source.1 (chr), publisher (chr), date
#>      (chr), type (chr), format (chr), identifier.2 (chr), identifier.1
#>      (chr), description (chr), language (chr), rights (chr), rights.1
#>      (chr), coverage (chr), subject (chr)
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
