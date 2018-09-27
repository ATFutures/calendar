context("test-test-ic_event")

test_that("error if start or end is NA", {
  expect_error(ic_event(start_time = NA, end_time = NA))
})

test_that("error if start or end is empty string", {
  expect_error(ic_event(start_time = Sys.time(), end_time = ""))
})

test_that("pass", {
  expect_equal(class(ic_event()), c("ical", "tbl_df", "tbl", "data.frame"))
})

context("test-test-ic_event_raw")
test_that("pass", {
  expect_equal(class(ic_event_raw()), c("ical", "tbl_df", "tbl", "data.frame"))
})

test_that("error if start or end is empty string", {
  expect_warning(ic_event_raw(start_time = Sys.time(), end_time = ""))
})
