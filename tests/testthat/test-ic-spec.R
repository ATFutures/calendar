context("test-ic-spec")

test_that("ic-spec downloads", {
  t <- ic_spec(mode = "read")
  expect_true(length(t) > 9000)
})
