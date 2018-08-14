#' View or download the ical specification
#'
#' This function shows the spec underlying iCal files.
#'
#' @param mode character string specifying whether to look at the spec (`mode = "view"`, the default)
#' or read it in (`mode = "read"`)
#' @param spec_url the location of the latest version of the spec, from
#' tools.ietf.org/rfc/rfc5545.txt by default
#' @export
ic_spec <- function(mode = "view", spec_url = "https://tools.ietf.org/rfc/rfc5545.txt") {
  if (mode == "view") {
    utils::browseURL(spec_url)
  } else if (mode == "read") {
    readLines(spec_url)
  }
}
