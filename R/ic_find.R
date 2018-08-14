#' Find contents of iCal fields
#'
#' @inheritParams ic_read
#' @param x Lines read-in in from an iCal file
#' @param pattern A text string to search from (an ical field)
#'
#' @export
#' @examples
#' pattern = "DTSTAMP"
#' ic_find(ical_example, pattern)
ic_find <- function(x, pattern) {
  pattern <- paste0(pattern, ":")
  locations <- grepl(x, pattern = pattern)
  locations
}
