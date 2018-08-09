#' ics files with R
#'
#' [iCalendar](https://icalendar.org/) is an open standard for
#' "exchanging calendar and scheduling information between users and computers".
#' Files adhering to this standard are save as `.ics` files.
#'
#' The `ical` package is for interacting with such files
#'
#' @import reticulate
#'
#' @docType package
#' @name ical
NULL

# globals
.ics <- NULL

.onLoad <- function(libname, pkgname) {

  # delay load ics.py
  .ics <<- reticulate::import("ics", delay_load = TRUE)

}

#' Install ics python package
#' @export
install_ics <- function() {
  reticulate::py_install("ics", method = "auto", conda = "auto")
}
