#' Convert ical datetime into R datetime
#' Z at the end of an ical stamp stands of Zulu time
#' https://en.wikipedia.org/wiki/Coordinated_Universal_Time#Time_zones
#' which is UTC = GMT https://greenwichmeantime.com/info/zulu/
#' @inheritParams ic_find
#' @export
#' @examples
#' ic_datetime("20180809T160000Z")
#' ic_date("20120103")
ic_datetime <- function(x) {

  # TODO (LH): regex check x timestamp
  if(any(!is.na(x) & !(x == "NA") & !grepl("^\\d{8}T\\d{6}Z?$", x))) {
    # stop("time should be in this format: 20180809T160000Z")
    warning("Non-standard time string: should be in this format: 20180809T160000Z")
    x = ""
  }

  plain <- gsub("[TZtz]", "", x)
  datetime <- as.POSIXct(plain, format = "%Y%m%d%H%M%S")
  datetime
}
#' Convert ical date into R date
#' @inheritParams ic_find
#' @export
#' @examples
#' ic_date("20120103")
ic_date <- function(x) {
  as.Date(x, format = "%Y%m%d")
}

#' Convert datetime object to character string
#' @param x datetime object
#' @param zulu is the datetime in Zulu time?
#' `FALSE` by default, which means the calendar's current timezone
#' is used.
#' @aliases ic_char_date
#' @export
#' @examples
#' x <- ic_datetime("20180809T160000")
#' ic_char_datetime(x) == "20180809T160000"
#' x <- ic_datetime("20180809T160000Z")
#' ic_char_datetime(x, zulu = TRUE) == "20180809T160000Z"
#' ic_char_date(as.Date("1985-12-26"))
ic_char_datetime = function(x, zulu = FALSE) {
  yr <- format.POSIXct(x, "%Y%m%d")
  ti <- format.POSIXct(x, "%H%M%S")
  yr_ti <- paste0(yr, "T", ti)
  if(zulu) {
    yr_ti <- paste0(yr_ti, "Z")
  }
  yr_ti
}
#' @export
ic_char_date = function(x) {
  format.Date(x, "%Y%m%d")
}
