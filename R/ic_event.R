#' Create ical object from properties_core inputs
#'
#' @param start_time start time, by default the current time to the nearest hour
#' @param end_time end time, by defult and hour (3600 seconds) after `start_time`
#' @param summary short outline of the event
#' @param more_properties add placeholder columns for properties in addition to `properties_core`,
#' dy default `FALSE`
#' @param properties named vector of additional properties to include, by default
#' with names `ical::properties` containing `NA`s to be subsequently populated
#' @return object of class ics
#' @export
#' @examples
#' ic_event()
#' ic_event(more_properties = TRUE)
ic_event <- function(
  uid = ic_guid(),
  start_time = as.POSIXct(round(Sys.time(), units = "hours")),
  end_time = as.POSIXct(round(Sys.time(), units = "hours") + 1 * 60 * 60),
  summary = "ical event",

  more_properties = FALSE,
  event_properties = setNames(
    rep(
      NA,
      length(setdiff(ical::properties, ical::properties_core))),
    nm = setdiff(ical::properties, ical::properties_core))) {
  #TODO: check inputs
  st <- ic_char_datetime(start_time)
  en <- ic_char_datetime(end_time)
  event_values <- c(uid, st, en, summary)
  # TODO: add DTSART and DTEND TZID types
  event <- paste(ical::properties_core, event_values, sep = ":")
  if(more_properties) {
    the_rest <- paste(names(event_properties), event_properties, sep = ":")
  } else {
    the_rest = NULL
  }
  ical(
    c(ical::properties_ical,
      "BEGIN:VEVENT",
      event,
      the_rest,
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
