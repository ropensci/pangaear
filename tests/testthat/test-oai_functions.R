context("oai functions")

test_that("pg_identify() works", {
  vcr::use_cassette("pg_identify", {
    aa <- pg_identify()
  })

  expect_is(aa, "pg_identify")
  expect_is(aa$repositoryName, "character")
})

test_that("pg_list_sets() works", {
  vcr::use_cassette("pg_list_sets", {
    aa <- pg_list_sets()
  })

  expect_is(aa, "tbl_df")
  expect_is(aa$setSpec, "character")
  expect_is(aa$setName, "character")
})

# test_that("pg_list_records() works", {
#   aa <- pg_list_records(from='2015-09-01', until='2015-10-03')

#   expect_is(aa, "data.frame")
#   expect_is(aa, "oai_df")
#   expect_match(aa$identifier, "oai:pangaea.de")
#   expect_is(aa$title, "character")
# })

test_that("pg_list_metadata_formats() works", {
  vcr::use_cassette("pg_list_metadata_formats", {
    aa <- pg_list_metadata_formats()
  })

  expect_is(aa, "data.frame")
  expect_named(aa, c('metadataPrefix', 'schema', 'metadataNamespace'))
  expect_true(any(grepl("oai_dc", aa$metadataPrefix)))
})

# pretty sure this is commented out because dates screw up testing, 
#    including with vcr
# test_that("pg_list_identifiers() works", {
#   skip_on_cran()
#
#   aa <- pg_list_identifiers(from = '2015-09-01', until = '2015-10-05')
#
#   expect_is(aa, "data.frame")
#   expect_is(aa, "oai_df")
#   expect_match(aa$identifier, "oai:pangaea.de")
# })

test_that("pg_get_record() works", {
  vcr::use_cassette("pg_get_record", {
    aa <- pg_get_record(identifier = "oai:pangaea.de:doi:10.1594/PANGAEA.788382")
  })

  expect_is(aa, "list")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]]$header, "tbl_df")
  expect_is(aa[[1]]$metadata, "tbl_df")
  expect_match(aa[[1]]$header$identifier, "oai:pangaea.de")
  expect_match(aa[[1]]$header$datestamp, "[0-9]{4}-[0-9]{2}-[0-9]{2}")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(pg_list_sets(as = "adsff"), "not in acceptable",
    class = "error")
  expect_error(pg_list_records(prefix = "adsfadf"), "unknown",
    class = "error")
  expect_error(pg_list_identifiers(from = 3), "badArgument",
    class = "error")
  expect_error(pg_get_record(identifier = 4444),
    "Identifier is not a valid OAI",
    class = "error")
})
