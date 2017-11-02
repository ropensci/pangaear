context("pg_data")

test_that("works well", {
  skip_on_cran()

  pg_cache_clear(prompt = FALSE)

  aa <- pg_data(doi = '10.1594/PANGAEA.807580')

  expect_is(aa, "list")
  expect_is(aa[[1]], "pangaea")
  expect_is(unclass(aa[[1]]), "list")
  expect_named(unclass(aa[[1]]), c('parent_doi', 'doi',
                                   'citation', 'url', 'path', 'data'))
  expect_is(unclass(aa[[1]])$data, "tbl_df")

  expect_equal(pg_cache_list(), '10_1594_PANGAEA_807580.txt')
})

test_that("fails well", {
  skip_on_cran()

  expect_error(pg_data(), "\"doi\" is missing")
  expect_error(pg_data(5), "not of right form")
})

test_that("zip files work", {
  skip_on_cran()

  aa <- pg_data(doi = "10.1594/PANGAEA.860500")

  expect_is(aa, "list")
  expect_is(aa[[1]], "pangaea")
  expect_is(unclass(aa[[1]]), "list")
  expect_named(unclass(aa[[1]]), c('parent_doi', 'doi',
                                   'citation', 'url', 'path', 'data'))
  expect_is(unclass(aa[[1]])$data, "data.frame")
  expect_named(unclass(aa[[1]])$data, c('Name', 'Length', 'Date'))
})

test_that("png files work", {
  skip_on_cran()
  skip_on_travis()

  aa <- pg_data(doi = "10.1594/PANGAEA.825428")

  expect_is(aa, "list")
  expect_is(aa[[1]], "pangaea")
  expect_is(unclass(aa[[1]]), "list")
  expect_named(unclass(aa[[1]]), c('parent_doi', 'doi',
                                   'citation', 'url', 'path', 'data'))

  # first result is a png
  expect_is(unclass(aa[[1]])$data, "character")
  expect_match(unclass(aa[[1]])$data, "readPNG")

  # other results are data.frames
  expect_is(unclass(aa[[2]])$data, "data.frame")
  expect_is(unclass(aa[[3]])$data, "data.frame")
  expect_is(unclass(aa[[4]])$data, "data.frame")
  expect_is(unclass(aa[[5]])$data, "data.frame")
})
