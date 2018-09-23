#' Extract raw contents of iCal fields
#'
#' Return info from iCal files, return raw unprocessed text.
#'
#' @inheritParams ic_find
#'
#' @export
#' @examples
#' pattern = "TSTAMP"
#' ic_extract(ical_example, pattern)
ic_extract_raw <- function(x, pattern) {
  locations <- ic_find(x, pattern)
  x_sub <- x[locations]
  res_raw <- gsub(pattern = paste0(pattern, ":"), replacement = "", x_sub)
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
#' ic_extract(ical_example, "DTSTART")
ic_extract <- function(x, pattern) {
  res_raw <- ic_extract_raw(x, pattern)
  # if(grepl(pattern, "DT")) {
  #   res = ic_datetime(res_raw)
  # }
}

#' Convert ical datetime into R datetime
#' Z at the end of an ical stamp stands of Zulu time
#' https://en.wikipedia.org/wiki/Coordinated_Universal_Time#Time_zones
#' which is UTC = GMT https://greenwichmeantime.com/info/zulu/
#'
#' @inheritParams ic_find
#'
#' @export
#' @examples
#' ic_datetime("20180809T160000Z")
ic_datetime <- function(x) {

  # TODO (LH): regex check x timestamp
  # if(!grepl(""^\\d{8}T\\d{6}Z?$"", x)) {
  #   stop("time should be in this format: 20180809T160000Z")
  # }

  plain <- gsub("[TZtz]", "", x)
  datetime <- as.POSIXct(plain, format = "%Y%m%d%H%M%S")
  datetime
}

#' Convert datetime object to character string
#' @param x datetime object
#' @export
#' @examples
#' x <- structure(1533826800, class = c("POSIXct", "POSIXt"), tzone = "")
#' ic_char_datetime(x) == "20180809T160000Z"
ic_char_datetime = function(x) {
  yr <- format.POSIXct(x, "%Y%m%d")
  ti <- format.POSIXct(x, "%H%M%S")
  paste0(yr, "T", ti, "Z")
}
