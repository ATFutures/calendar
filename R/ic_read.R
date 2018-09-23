#' Read ics file
#'
#' @param file ics file to read
#' @return object of class ics
#' @export
#' @examples
#' f <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' ics_df = ic_read(f)
#' head(ics_df)
ic_read <- function(file) {
  x <- readLines(file)

  # previous approach: see https://stackoverflow.com/questions/43573982/how-to-import-ical-ics-file-in-r
  ical(x)
}
#' Write ics file
#'
#' @inheritParams ic_character
#' @param file ics file to write
#' @export
#' @examples
#' ic <- ical(ical_example)
#' ic_write(ic, "ic.ics")
#' f <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' ics_df <- ic_read(f)
#' ic_write(ics_df, "ic.ics")
#' # test similarity between files with diff tool like meld - from shell:
#' # meld ic.ics inst/extdata/england-and-wales.ics
#' file.remove("ic.ics")
ic_write <- function(ic, file) {
  ic_char <- ic_character(ic)
  writeLines(ic_char, file)
}
