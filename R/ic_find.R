#' Find contents of iCal fields
#'
#' @inheritParams ic_read
#' @param x Lines read-in in from an iCal file
#' @param pattern A text string to search from (an ical field)
#'
#' @export
#' @examples
#' f <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' x = readLines(f)
#' x[1:20]
#' pattern = "DTSTAMP"
#' dtstamp = ic_find(x, pattern)
#' head(dtstamp)
ic_find <- function(x, pattern) {
  pattern <- paste0(pattern, ":")
  locations = grepl(x, pattern = pattern)
  x_sub = x[locations]
  res = gsub(pattern = pattern, replacement = "", x_sub)
  res
}
