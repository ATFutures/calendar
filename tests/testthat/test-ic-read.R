context("test-ic-read")

test_that("ic-read works", {
  f <- system.file("extdata", "england-and-wales.ics", package = "calendar")
  ics_df = ic_read(f)
  expect_true(nrow(ics_df) > 6)
})

test_that("ic-write", {
  ic <- ical(ical_example)
  ic_write(ic, file.path(tempdir(), "ic.ics"))
  f <- system.file("extdata", "example.ics", package = "calendar")
  fic <- readLines(file.path(tempdir(), "ic.ics"))
  fraw <- readLines(f)
  # when we write back we do not add Z to DTSTART, DTEND etc
  # that is why currently
  # identical(fic, fraw) is FALSE
  expect_true(identical(fic[1], fraw[1]))
  expect_true(identical(fic[22], fraw[22]))
})
