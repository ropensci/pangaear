context("pg_data")

pg_cache$delete_all()
pg_cache$cache_path_set(full_path = "../files")

test_that("works well", {
  skip_on_cran()
  skip_on_travis()

  vcr::use_cassette("pg_data1", {
    aa <- pg_data(doi = '10.1594/PANGAEA.807580')
  })

  expect_is(aa, "list")
  expect_is(aa[[1]], "pangaea")
  expect_is(unclass(aa[[1]]), "list")
  expect_named(unclass(aa[[1]]), c('parent_doi', 'doi',
                                   'citation', 'url', 'path', 'metadata', 'data'))
  expect_is(unclass(aa[[1]])$data, "tbl_df")

  # expect_equal(basename(pg_cache$list()), '10_1594_PANGAEA_807580.txt')
})

test_that("fails well", {
  skip_on_cran()

  expect_error(pg_data(), "\"doi\" is missing")
  expect_error(pg_data(5), "not of right form")
})

test_that("zip files work", {
  skip_on_cran()
  skip_on_travis()

  vcr::use_cassette("pg_data_zip_files", {
    aa <- pg_data(doi = "10.1594/PANGAEA.860500")
  })

  expect_is(aa, "list")
  expect_is(aa[[1]], "pangaea")
  expect_is(unclass(aa[[1]]), "list")
  expect_named(unclass(aa[[1]]), c('parent_doi', 'doi',
                                   'citation', 'url', 'path', 'metadata', 'data'))
  expect_is(unclass(aa[[1]])$data, "data.frame")
  expect_identical(unclass(aa[[1]])$metadata, list())
  expect_named(unclass(aa[[1]])$data, c('Name', 'Length', 'Date'))
})

test_that("png files work", {
  skip_on_cran()
  skip_on_travis()

  vcr::use_cassette("pg_data_png_files", {
    aa <- pg_data(doi = "10.1594/PANGAEA.825428")
  })

  expect_is(aa, "list")
  expect_is(aa[[1]], "pangaea")
  expect_is(unclass(aa[[1]]), "list")
  expect_named(unclass(aa[[1]]), c('parent_doi', 'doi',
                                   'citation', 'url', 'path', 'metadata', 'data'))

  # first result is a png
  expect_is(unclass(aa[[1]])$data, "character")
  expect_match(unclass(aa[[1]])$data, "readPNG")

  # other results are data.frames
  expect_is(unclass(aa[[2]])$data, "data.frame")
  expect_is(unclass(aa[[3]])$data, "data.frame")
  expect_is(unclass(aa[[4]])$data, "data.frame")
  expect_is(unclass(aa[[5]])$data, "data.frame")

  # metadata
  expect_identical(aa[[1]]$metadata, list())
})

test_that("text data file with metadata", {
  skip_on_cran()
  skip_on_travis()

  vcr::use_cassette("pg_data_text_files_with_metadata", {
    aa <- pg_data(doi = "10.1594/PANGAEA.807580")
  })

  expect_is(aa, "list")
  expect_is(aa[[1]], "pangaea")
  expect_is(aa[[1]]$metadata, "list")
  expect_is(aa[[1]]$metadata$citation, "character")
  expect_is(aa[[1]]$metadata$coverage, "character")
  expect_is(aa[[1]]$metadata$license, "character")

  # parameters has extra parsing
  ## its a list
  expect_is(aa[[1]]$metadata$parameters, "list")
  ## not named
  expect_named(aa[[1]]$metadata$parameters, NULL)
  ## length of the list of parameters should equal columns of data
  expect_equal(length(aa[[1]]$metadata$parameters), NCOL(aa[[1]]$data))
})
