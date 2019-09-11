context("pg_search")

test_that("pg_search works and stuff, and stuff and things, also, it works", {
  vcr::use_cassette("pg_search", {
    aa <- pg_search(query='water')
    bb <- pg_search(query='water', count=2)
    cc <- pg_search(query='water', topic="Oceans")
    dd <- pg_search(query='water', mindate="2013-06-01", maxdate="2013-07-01")
    ee <- pg_search(query='water', bbox=c(-124.2, 41.8, -116.8, 46.1))
    ff <- pg_search(query='citation:Archer')
  }, preserve_exact_body_bytes = TRUE)

  expect_is(aa, "tbl_df")
  expect_equal(sort(names(aa)),
            c('citation', 'doi','score','size','size_measure','supplement_to'))
  expect_match(aa$doi, "10.1594")
  expect_is(aa$score, "numeric")
  expect_is(aa$size, "numeric")
  expect_is(aa$size_measure, "character")
  expect_is(aa$supplement_to, "character")

  expect_is(bb, "tbl_df")
  expect_is(cc, "tbl_df")
  expect_is(dd, "tbl_df")
  expect_is(ee, "tbl_df")
  expect_is(ff, "tbl_df")
})

test_that("pg_search paging works", {
  vcr::use_cassette("pg_search_pagination", {
    res1 <- pg_search(query = "florisphaera", count = 10)
    res2 <- pg_search(query = "florisphaera", count = 10, offset = 10)
    res3 <- pg_search(query = "florisphaera", count = 10, offset = 20)
  }, preserve_exact_body_bytes = TRUE)

  expect_is(res1, "tbl_df")
  expect_is(res2, "tbl_df")
  expect_is(res3, "tbl_df")

  expect_equal(NROW(res1), 10)
  expect_equal(NROW(res2), 10)
  expect_equal(NROW(res3), 10)

  expect_gte(min(res1$score), max(res2$score))
  expect_gte(min(res2$score), max(res3$score))

  expect_false(identical(res1$doi, res2$doi))
  expect_false(identical(res2$doi, res3$doi))
  expect_false(identical(res1$doi, res3$doi))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(pg_search(), "argument \"query\" is missing")
  expect_error(pg_search("water", count = "asdafd"), "count must be of class")
  expect_error(pg_search("water", topic = 5), "topic must be of class")
  expect_error(pg_search("water", mindate = 5), "mindate must be of class")
  expect_error(pg_search("water", maxdate = 5), "maxdate must be of class")
  expect_error(pg_search("water", env = 5), "'env' has been removed")
})
