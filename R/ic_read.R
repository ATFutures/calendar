#' Read ics file
#'
#' @param file ics file to read
#' @return object of class ics
#' @export
#'
#' @examples
#' f <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' ics_df = ic_read(f)
#' head(ics_df)
ic_read <- function(file) {

  x <- readLines(file)

  # previous approach: see https://stackoverflow.com/questions/43573982/how-to-import-ical-ics-file-in-r
  timestamps_char = ic_find(x, "DTSTAMP")

  # do something with the contents
  df
}
