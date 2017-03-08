context("pg_identify")

test_that("pg_identify works", {
  skip_on_cran()

  aa <- pg_identify()

  expect_is(aa, "pg_identify")
  expect_is(unclass(aa), "list")

  expect_type(aa$repositoryName, "character")
  expect_type(aa$baseURL, "character")
  expect_type(aa$protocolVersion, "character")
})
