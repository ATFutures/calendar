#' Extract raw contents of iCal fields
#'
#' Return info from iCal files, return raw unprocessed text.
#'
#' @inheritParams ic_find
#'
#' @export
#' @examples
#' pattern = "TSTAMP"
#' ic_extract(ic_example, pattern)
ic_extract_raw <- function(x, pattern) {

  locations = ic_find(x, pattern)
  x_sub = x[locations]
  res_raw = gsub(pattern = paste0(pattern, ":"), replacement = "", x_sub)
  res_raw

}

#' Extract contents of iCal fields
#'
#' Return formatted data from iCal fields
#'
#' @inheritParams ic_find
#'
#' @export
#' @examples
#' ic_extract(ic_example, "DTSTART")
ic_extract <- function(x, pattern) {

  res_raw = ic_extract_raw(x, pattern)
  # if(grepl(pattern, "T")) {
  #
  # }

}

# ic_extract_date = function(res_raw) {
#
# }