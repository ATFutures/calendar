context("test-ic-extract")

# now that we are setting zulu time strings to zulu time in ic_date() to test against a specific 
# time zone datetime we need to set it first
test_that("ic_extract works", {
  test_datetime <- ic_extract(ical_example, "DTSTART")
  attr(test_datetime, "tzone") <- "Europe/London"
  expect_equal(test_datetime,
               as.POSIXct("2018-08-09 17:00:00", tz = "Europe/London"))
})


