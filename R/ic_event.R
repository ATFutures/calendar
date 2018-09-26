#' Create ical object from properties_core inputs
#'
#' @param start start time
#' @param end end time
#' @param summary short outline of the event
#' @return object of class ics
#' @export
#' @examples
#' ic_event()
ic_event <- function(start = Sys.time(),
                     end = Sys.time() + 1*60*60,
                     summary = "R ical event") {
  #TODO: check inputs
  st <- ic_char_datetime(start)
  en <- ic_char_datetime(end)
  event.values <- c(ic_guid(), st, en, summary)
  # TODO: add DTSART and DTEND TZID types
  event <- paste(ical::properties_core, event.values, sep = ":")
  the.rest <- ical::properties[!ical::properties %in% names(ical::properties_core)]
  the.rest <- paste(the.rest, rep("", length(the.rest)), sep = ":")
  ical(
    c(ical::properties_ical,
      "BEGIN:VEVENT",
      event,
      the.rest,
      "END:VEVENT",
      "END:VCALENDAR"
      )
    )
 }

#' Get an ical GUID
#'
#' Provided without any testing. Slight improvement from
#' [SO question](https://stackoverflow.com/a/10493590/2332101)
#' @examples
#' ic_guid()
#' @export
ic_guid <- function() {
  baseuuid <- paste(sample(c(letters[1:6],0:9),30,replace=TRUE),collapse="")
  paste(
    "ical-",
    substr(baseuuid,1,8),
    "-",
    substr(baseuuid,9,12),
    "-",
    "4",
    substr(baseuuid,13,15),
    "-",
    sample(c("8","9","a","b"),1),
    substr(baseuuid,16,18),
    "-",
    substr(baseuuid,19,30),
    sep="",
    collapse=""
  )
}
