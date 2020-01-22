context("pg_search_es")

test_that("pg_search_es", {
  vcr::use_cassette("pg_search_es", {
    aa <- pg_search_es()
  }, preserve_exact_body_bytes = TRUE)

  expect_is(aa, "tbl_df")
  expect_is(aa, "data.frame")
  expect_is(attributes(aa), "list")

  expect_type(attr(aa, "total"), "integer")
  expect_type(attr(aa, "max_score"), "double")

  expect_type(aa$`_index`, "character")
  expect_type(aa$`_source.eastBoundLongitude`, "double")
})

test_that("pg_search_es parameters work", {
  vcr::use_cassette("pg_search_es_pagination", {
    aa <- pg_search_es(size = 1)
  }, preserve_exact_body_bytes = TRUE)

  expect_is(aa, "tbl_df")
  expect_equal(NROW(aa), 1)
})

test_that("fails well", {
  skip_on_cran()

  expect_error(pg_search_es(size = "asdffd"),
               "size must be of class: numeric, integer")
  expect_error(pg_search_es(from = "asdffd"),
               "from must be of class: numeric, integer")
  expect_error(pg_search_es(source = 5),
               "source must be of class: character")
  expect_error(pg_search_es(analyze_wildcard = "asdffd"),
               "analyze_wildcard must be of class: logical")
})
