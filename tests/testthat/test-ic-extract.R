context("test-ic-extract")

test_that("ic_extract works", {
  expect_equal(ic_extract(ical_example, "DTSTART"),
               as.POSIXct("2018-08-09 16:00:00 BST"))
})
