context("test-test-ic_event")

test_that("error if start or end is NA", {
  expect_warning(ic_event(start_time = NA, end_time = NA))
})

test_that("error if start or end is empty string", {
  expect_warning(ic_event(start_time = Sys.time(), end_time = ""))
})

test_that("default values work", {
  expect_equal(class(ic_event()), c("ical", "tbl_df", "tbl", "data.frame"))
})

test_that("2018-10-12 15:00, end_time = 2018-10-13 15:00 matches default format", {
  expect_equal(class(ic_event()), c("ical", "tbl_df", "tbl", "data.frame"))
})

test_that("error if start or end is empty string", {
  expect_warning(ic_event(start_time = Sys.time(), end_time = ""))
})
