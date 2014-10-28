pangaear
========



[![Build Status](https://api.travis-ci.org/ropensci/pangaear.png)](https://travis-ci.org/ropensci/pangaear)
[![Build status](https://ci.appveyor.com/api/projects/status/564oioj2oyefax08?svg=true)](https://ci.appveyor.com/project/sckott/pangaear)

An R client to interact with the [Pangaea database](http://www.pangaea.de/).

## Info

* Pangaea [website](http://www.pangaea.de/).
* Pangaea [OAI-PMH docs](http://wiki.pangaea.de/wiki/OAI-PMH).
* [OAI-PMH Spec](http://www.openarchives.org/OAI/openarchivesprotocol.html)

## Quick start

### Installation


```r
install.packages("devtools")
devtools::install_github('ropensci/pangaear')
```


```r
library('pangaear')
```

### Search for data

This is a thin wrapper around the GUI search interface on the page [http://www.pangaea.de/](http://www.pangaea.de/). Everything you can do there, you can do here.


```r
pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1), count=3)
#>                      doi score_per size_datasets
#> 1 10.1594/PANGAEA.736010       100             9
#> 2 10.1594/PANGAEA.803591        96             2
#> 3 10.1594/PANGAEA.812094        91             2
#>                                                                                                                          citation
#> 1                                           Archer, DE; Devol, AH (1992): Benthic oxygen flixes on the Washington shelf and slope
#> 2 Lorenson, TD; Collett, TS (2000): Gas content, composition of gas hydrate and volumetric gas/water ratios of ODP and DSDP sites
#> 3                                              Simonyan, AV; Dultz, S; Behrens, H (2012): Diffusion transport of water in basalts
#>                                                                                                                                                                                                                                                                                                                supplement_to
#> 1                                                                                                                                    Archer, DE; Devol, AH (1992): Benthic oxygen fluxes on the Washington shelf and slope: A comparison of in situ microelectrode and chamber flux measurements. Limnology and Oceanography
#> 2 Lorenson, TD; Collett, TS (2000): Gas content and composition of gas hydrate from sediments of the southeastern North American continental margin. In: Paull, CK; Matsumoto, R; Wallace, PJ; Dillon, WP (eds.) Proceedings of the Ocean Drilling Program, Scientific Results, College Station, TX (Ocean Drilling Program)
#> 3                                                                                                                                                                               Simonyan, AV; Dultz, S; Behrens, H (2012): Diffusive transport of water in porous fresh to altered mid-ocean ridge basalts. Chemical Geology
#>   related_to
#> 1         NA
#> 2         NA
#> 3         NA
```

### Get data


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
#> Variables not shown: Depth water [m] (int), Temp [Â°C] (dbl), Sal (dbl),
#>      Tpot [Â°C] (dbl)
```

Search for data then pass DOI to data function.


```r
res <- pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1), count=3)
pg_data(res$doi[3])
#> [[1]]
#> <Pangaea data> 10.1594/PANGAEA.812092
#>         Event Latitude Longitude Elevation [m]                Label
#> 1    169-856H   48.434  -128.681         -2423       169-856H-55R-1
#> 2    169-856H   48.434  -128.681         -2423 169-856H-57R-1,52-54
#> 3    169-856H   48.434  -128.681         -2423 169-856H-64R-2,93-95
#> 4    169-856H   48.434  -128.681         -2423 169-856H-65R-1,35-38
#> 5  SO145/2_20  -14.153  -112.514         -2650        20DS4-surface
#> 6  SO145/2_20  -14.153  -112.514         -2650           20DS4-core
#> 7  SO145/2_29  -14.825  -111.907         -3355        29DS2-surface
#> 8  SO145/2_29  -14.825  -111.907         -3355           29DS2-core
#> 9  SO145/2_36  -14.892  -109.187         -3503        36DS1-surface
#> 10 SO145/2_36  -14.892  -109.187         -3503           36DS1-core
#> ..        ...      ...       ...           ...                  ...
#> Variables not shown: Samp com (chr), Depth [m] (dbl), Age [ka BP] (int),
#>      Rock (chr), Alteration (chr), DBD [g/cm**3] (dbl), Poros frac (MIP)
#>      (dbl), Pore radius mean [mm] (dbl), SSA [m**2/g] (dbl), Poros frac
#>      (#1 NIR) (dbl), Poros frac (#2 NIR) (dbl), Water dm [%] (dbl),
#>      Minerals (chr)
#> 
#> [[2]]
#> <Pangaea data> 10.1594/PANGAEA.812093
#>       Event          Label                                      Samp com
#> 1  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 2  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 3  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 4  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 5  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 6  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 7  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 8  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 9  169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> 10 169-856H 169-856H-55R-1 complete altered, thickness of basalt =200 µm
#> ..      ...            ...                                           ...
#> Variables not shown: Depth [m] (dbl), Distance [Âµm] (int), T tech [Â°C]
#>      (dbl), Run (chr), - (initial concentration of diff...) (dbl), -
#>      (initial concentration of diff...) (dbl), Poros frac (#1, from fit)
#>      (dbl), Poros frac (#2, from fit) (dbl), Diff coeff [10**-6 cm**2/s]
#>      (dbl), Diff coeff std dev [Â±] (effective from fit) (dbl), Diff coeff
#>      std dev [Â±] (effective total) (dbl), X (dbl), X (average) (int), F
#>      (int), - (m) (dbl)
```

### OAI-PMH metadata

#### Identify the service


```r
pg_identify()
#> <Pangaea>
#>   repositoryName: PANGAEA - Data Publisher for Earth & Environmental Science
#>   baseURL: http://ws.pangaea.de/oai/
#>   protocolVersion: 2.0
#>   adminEmail: tech@pangaea.de
#>   adminEmail: tech@pangaea.de
#>   earliestDatestamp: 2009-03-14T00:00:00Z
#>   deletedRecord: transient
#>   granularity: YYYY-MM-DDThh:mm:ssZ
#>   compression: gzip,deflate
#>   description: oaipangaea.de:oai:pangaea.de:doi:10.1594/PANGAEA.999999
```

#### List metadata formats


```r
pg_list_metadata_formats()
#>   metadataPrefix                                                 schema
#> 1         oai_dc         http://www.openarchives.org/OAI/2.0/oai_dc.xsd
#> 2         pan_md      http://ws.pangaea.de/schemas/pangaea/MetaData.xsd
#> 3            dif http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/dif_v9.4.xsd
#> 4       iso19139               http://www.isotc211.org/2005/gmd/gmd.xsd
#> 5  iso19139.iodp               http://www.isotc211.org/2005/gmd/gmd.xsd
#>                             metadataNamespace
#> 1 http://www.openarchives.org/OAI/2.0/oai_dc/
#> 2              http://www.pangaea.de/MetaData
#> 3  http://gcmd.gsfc.nasa.gov/Aboutus/xml/dif/
#> 4            http://www.isotc211.org/2005/gmd
#> 5            http://www.isotc211.org/2005/gmd
```

#### List identifiers


```r
head( pg_list_identifiers(from='2012-01-01', until='2012-01-05') )
#>                                  identifier            datestamp setSpec
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.510194 2012-01-04T16:02:57Z        
#> 2 oai:pangaea.de:doi:10.1594/PANGAEA.510195 2012-01-04T16:02:51Z        
#> 3 oai:pangaea.de:doi:10.1594/PANGAEA.699614 2012-01-03T11:21:24Z        
#> 4 oai:pangaea.de:doi:10.1594/PANGAEA.699615 2012-01-03T11:21:24Z        
#> 5 oai:pangaea.de:doi:10.1594/PANGAEA.699616 2012-01-03T11:21:25Z        
#> 6 oai:pangaea.de:doi:10.1594/PANGAEA.699617 2012-01-03T11:21:25Z
```

#### List sets


```r
head( pg_list_sets() )
#>        setSpec                                               setName
#> 1   jcorestest   Datasets with PANGAEA technical keyword @jcorestest
#> 2 paleoclimate Datasets with PANGAEA technical keyword @paleoclimate
#> 3       IMAGES       Datasets with PANGAEA technical keyword @IMAGES
#> 4       SFB313       Datasets with PANGAEA technical keyword @SFB313
#> 5       ORFOIS       Datasets with PANGAEA technical keyword @ORFOIS
#> 6         WATT         Datasets with PANGAEA technical keyword @WATT
```

#### List records


```r
res <- pg_list_records(from='2012-01-01', until='2012-01-15')
head(res$headers); NROW(res$headers)
#>                                  identifier            datestamp setSpec
#> 1 oai:pangaea.de:doi:10.1594/PANGAEA.188779 2012-01-11T10:07:35Z        
#> 2 oai:pangaea.de:doi:10.1594/PANGAEA.510104 2012-01-11T22:31:30Z        
#> 3 oai:pangaea.de:doi:10.1594/PANGAEA.510105 2012-01-11T22:31:38Z        
#> 4 oai:pangaea.de:doi:10.1594/PANGAEA.510106 2012-01-11T22:42:31Z        
#> 5 oai:pangaea.de:doi:10.1594/PANGAEA.510107 2012-01-11T22:42:21Z        
#> 6 oai:pangaea.de:doi:10.1594/PANGAEA.510108 2012-01-11T22:48:22Z
#> [1] 100
```

#### Geta a record


```r
record <- pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
record$header
#> $identifier
#> [1] "oai:pangaea.de:doi:10.1594/PANGAEA.788382"
#> 
#> $datestamp
#> [1] "2014-10-22T14:33:02Z"
#> 
#> $setSpec
#> [1] "citable"
#> 
#> $setSpec
#> [1] "geocode1600"
#> 
#> $setSpec
#> [1] "geocode1601"
#> 
#> $setSpec
#> [1] "project4026"
record$metadata
#> $dc
#> $dc$title
#> [1] "Trace metals in shells of mussels and clams from deep-sea hydrothermal vent fields of the Mid-Atlantic Ridge and East Pacific Rise"
#> 
#> $dc$creator
#> [1] "Demina, Lyudmila L"
#> 
#> $dc$creator
#> [1] "Galkin, Sergey V"
#> 
#> $dc$creator
#> [1] "Dara, OM"
#> 
#> $dc$source
#> [1] "P.P. Shirshov Institute of Oceanology, Russian Academy of Sciences, Moscow"
#> 
#> $dc$source
#> [1] "Supplement to: Demina, Lyudmila L; Galkin, Sergey V; Dara, OM (2012): Trace metal bioaccumulation in the shells of mussels and clams at deep-sea hydrothermal vent fields. Translated from Geokhimiya, 2012, 50(2), 147-163, Geochemistry International, 50(2), 133-147, doi:10.1134/S0016702911120056"
#> 
#> $dc$publisher
#> [1] "PANGAEA"
#> 
#> $dc$date
#> [1] "2012-09-07"
#> 
#> $dc$type
#> [1] "Dataset"
#> 
#> $dc$format
#> [1] "application/zip, 5 datasets"
#> 
#> $dc$identifier
#> [1] "http://doi.pangaea.de/10.1594/PANGAEA.788382"
#> 
#> $dc$identifier
#> [1] "doi:10.1594/PANGAEA.788382"
#> 
#> $dc$description
#> [1] "Bioaccumulation of trace metals in carbonate shells of mussels and clams was investigated at seven hydrothermal vent fields of the Mid-Atlantic Ridge (Menez Gwen, Snake Pit, Rainbow, and Broken Spur) and the Eastern Pacific (9°N and 21°N at the East Pacific Rise and the southern trough of Guaymas Basin, Gulf of California). Mineralogical analysis showed that carbonate skeletons of mytilid mussel Bathymodiolus sp. and vesicomyid clam Calyptogena m. are composed mainly of calcite and aragonite, respectively. The first data were obtained for contents of a variety of chemical elements in bivalve carbonate shells from various hydrothermal vent sites. Analyses of chemical compositions (including Fe, Mn, Zn, Cu, Cd, Pb, Ag, Ni, Cr, Co, As, Se, Sb, and Hg) of 35 shell samples and 14 water samples from mollusk biotopes revealed influences of environmental conditions and some biological parameters on bioaccumulation of metals. Bivalve shells from hydrothermal fields with black smokers are enriched in Fe and Mn by factor of 20-30 relative to the same species from the Menez Gwen low-temperature vent site. It was shown that essential elements (Fe, Mn, Ni, and Cu) more actively accumulated during early ontogeny of the shells. High enrichment factors of most metals (n x 100 - n x 10000) indicate efficient accumulation function of bivalve carbonate shells. Passive metal accumulation owing to adsorption on shell surfaces was estimated to be no higher than 50% of total amount and varied from 14% for Fe to 46% for Mn."
#> 
#> $dc$language
#> [1] "en"
#> 
#> $dc$rights
#> [1] "CC-BY: Creative Commons Attribution 3.0 Unported"
#> 
#> $dc$rights
#> [1] "Access constraints: unrestricted"
#> 
#> $dc$coverage
#> [1] "MEDIAN LATITUDE: 29.437467 * MEDIAN LONGITUDE: -62.287367 * SOUTH-BOUND LATITUDE: 9.833000 * WEST-BOUND LONGITUDE: -111.400000 * NORTH-BOUND LATITUDE: 37.840000 * EAST-BOUND LONGITUDE: -31.516667"
#> 
#> $dc$subject
#> [1] "Ag; Ag std dev; Antimony; Antimony, standard deviation; Aragonite; Archive of Ocean Data; ARCOD; Area; Area/locality; Arg; Arsenic; Arsenic, standard deviation; As; As std dev; Atomic absorption spectrometry (AAS); Ba; Barium; Barium, standard deviation; Ba std dev; Ca; Cadmium; Cadmium, standard deviation; Cal; Calcite; Calcium; Calcium, standard deviation; Calculated; Carbon, organic, total; Carbon analyser AN-7529, 7560; Ca std dev; Cd; Cd std dev; Chromium; Chromium, standard deviation; Co; Cobalt; Cobalt, standard deviation; Copper; Copper, standard deviation; Co std dev; Cr; Cr std dev; Cu; Cu std dev; d13C carb; d13C std dev; delta 13C, carbonate; delta 13C, standard deviation; deviation; EF; Enrichment factor; Fe; Fe std dev; Hg; Hg std dev; Instrumental neutron activation analysis (INAA); Iron; Iron, standard deviation; K; K std dev; Lab no; Lead; Lead, standard deviation; Manganese; Manganese, standard deviation; Mass spectrometry; Mercury; Mercury, standard deviation; Mn; Mn std dev; Na; Na std dev; Ni; Nickel; Nickel, standard deviation; Ni std dev; NOBS; Number of observations; Organ; Pb; Pb std dev; Potassium; Potassium, standard deviation; Ruler tape; Samp com; Sample, optional label/labor no; Sample comment; Sample type; Samp type; Sb; Sb std dev; Se; Selenium; Shell l; Shell length; Silver; Silver, standard deviation; Sodium; Sodium, standard deviation; Species; Sr; Sr std dev; Strontium; Strontium, standard deviation; Taxa; Taxon/taxa; TOC; X-ray diffraction; Zinc; Zinc, standard deviation; Zn; Zn std dev"
#> 
#> $dc$.attrs
#>                                                                               schemaLocation 
#> "http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd" 
#> attr(,"namespaces")
#> http://www.w3.org/2001/XMLSchema-instance 
#>                                     "xsi"
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

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
