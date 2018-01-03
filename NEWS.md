pangaear 0.6.0
==============

## MINOR IMPROVEMENTS

* Added a vignette (#62)
* replaced `httr` pkg with `crul` for HTTP requests (#55)
* Some datasets require login on the Pangaea platform - we now detect this in `pg_data` and skip the file download with a message saying so. Eventually we hope to fix this to allow uesrs to input credentials to get the file(s) (#59)


pangaear 0.3.0
==============

## NEW FEATURES

* New function `pg_search_es` - an interface to Pangaea's Elasticsearch
query interface.

## MINOR IMPROVEMENTS

* added more tests (#57)
* now using markdown in docs 
* tidy code to 80 line width

## BUG FIXES

* fixed bug in oai functions due to changed base url for the 
Pangaea OAI server (#53)
* Fix to `pg_search` as search portal now has offset param - so if
more than 500 results need to page through them with the 
`offset` parameter (#56)


pangaear 0.2.4
==============

## MINOR IMPROVEMENTS

* Improved examples in the OAI methods to make sure they work 
regardless of when the user runs them

## BUG FIXES

* Fixes to `pg_search()` needed due to changes in the Pangaea 
website. Nearly identical functionality, but one parameter switch
(`env` param is now `topic`). More parameters may be added in the 
future. New fields are added to output, added to docs for the 
function. Now importing `jsonlite` as a result of these changes (#50)
* Fixes to `pg_data()` needed due to changes in the Pangaea 
website. Nothing should be different for the user. (#51)


pangaear 0.2.0
==============

## MINOR IMPROVEMENTS

* Dropped `XML`, using `xml2` now (#42)
* Using `rappdirs` package now for determing caching path on user's machine (#46)
* using `tibble` now for compact data.frame representations (#47)
* Dropped `methods` dependency (#48)
* Added test suite (#45)

## BUG FIXES

* Fixes to `pg_search()` - introduced due to changes in Pangaea website (#44)

pangaear 0.1.0
==============

* Released to CRAN.
