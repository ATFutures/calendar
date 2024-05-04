context("test-ic_datetime.R")

# test_that("multiplication works", {
#   expect_equal(2 * 2, 4)
# })

test_that("ic_datetime works for 20180809T160000Z:", {
  expect_equal(
    class(ic_datetime("20180809T160000Z")), class(Sys.time())
  )
})

test_that("ic_datetime is NA for empty:", {
  expect_output(ic_datetime(""), NA)
})

test_that("DTSTART & DTEND time zones equal local time zone ''", {
  f <- system.file("extdata", "apple_calendar_test.ics", package = "calendar") # "Pacific/Auckland" chosen as original time zone as different to testers local time zone
  ics_df = ic_read(f)
  expect_equal(attributes(ics_df$DTSTART)$tzone, "")
  expect_equal(attributes(ics_df$DTEND)$tzone, "")
})
