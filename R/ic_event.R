#' Create ical object from properties_core inputs
#'
#' Create an ical event using either POSIXct type or character type with format parameters.
#'
#' @param uid the unique id of the event, by default generated by `ic_uid()`
#' @param start_time start time, by default the start time plus one hour
#' @param end_time a number representing the number of hours
#' after `start_time` or an datetime object (of class `POSIXct`) when
#' the event ends. By default set to `1`, meaning 1 hour after `start_time`.
#' @param format required if start_time and end_time are vectors and are not of datetime format
#' "%Y-%m-%d %H:%M", you can use `calendar::formats` object for convenience.
#' @param summary short outline of the event
#' @param more_properties add placeholder columns for properties in addition to `properties_core`,
#' dy default `FALSE`
#' @param event_properties named vector of additional properties to include. By default
#' These include names stored in the data object `properties` (a packaged dataset),
#' containing `NA`s to be subsequently populated.
#' @format in case of start_time and end_time being character values, a format must be provided.
#'
#' @return object of class ics
#' @export
#' @examples
#' ic_event()
#' s <- lubridate::ymd_h("2019-01-01 00")
#' ic_event(start_time = s, end_time = 3)
#' # also accepts this format by default, thanks to lubridate::ymd_h:
#' ic_event(start_time = "2019-01-01 00")
#' ic_event(more_properties = TRUE)
#' ic_event(start_time = "18-10-12", end_time = "18-10-13", format = calendar::formats$`yy-mm-dd`)
ic_event <- function(
                     uid = ic_guid(),
                     start_time = as.POSIXct(round.POSIXt(Sys.time(), units = "hours")),
                     end_time = 1,
                     format = "%Y-%m-%d %H:%M",
                     summary = "ical event",
                     more_properties = FALSE,
                     event_properties = calendar::properties) {
  posixct <- "POSIXct"
  # inputs
  if (is.na(summary) | summary == "NA") {
    summary <- "ical event"
  }

  # I think ic_event should be stricter - all these
  # format helpers could help create a datetime event (RL)
  # suggestion: put the following into a new function e.g called ic_datetime()
  # TODO: mix and match start = Sys.time() finish = "2018-10-12 15" and a format.
  if (is.na(start_time)) {
    warning("no value provided for end time")
    start_time <- as.POSIXct(round.POSIXt(Sys.time(), units = "hours"))
  }
  if (is.na(end_time)) {
    warning("no value provided for end time")
    end_time <- start_time + 60^2 * 1
  }
  if (is.character(start_time)) {
    if (nchar(start_time) == 13) {
      start_time <- lubridate::ymd_h(start_time)
    } else {
      start_time <- as.POSIXct(start_time, format = format)
    }
  }

  if (is.numeric(end_time)) {
    end_time <- start_time + 60^2 * end_time
  } else if (is.character(end_time)) {
    if (nchar(end_time) == 13) {
      end_time <- lubridate::ymd_h(end_time)
    } else {
      end_time <- as.POSIXct(end_time, format = format)
    }
  }
  start_time_char <- ic_char_datetime(start_time)
  end_time_char <- ic_char_datetime(end_time)
  event_values <- c(uid, start_time_char, end_time_char, summary)
  # TODO: add DTSART and DTEND TZID types
  if (identical(event_properties, calendar::properties)) {
    # just moving this out of the method signature.
    stats::setNames(
      rep(
        NA,
        length(setdiff(calendar::properties, calendar::properties_core))
      ),
      nm = setdiff(calendar::properties, calendar::properties_core)
    )
  }
  event <- paste(calendar::properties_core, event_values, sep = ":")
  if (more_properties) {
    the_rest <- paste(names(event_properties), event_properties, sep = ":")
  } else {
    the_rest <- NULL
  }
  ical(
    c(
      calendar::properties_ical,
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
  baseuuid <- paste(sample(c(letters[1:6], 0:9), 30, replace = TRUE), collapse = "")
  paste(
    "ical-",
    substr(baseuuid, 1, 8),
    "-",
    substr(baseuuid, 9, 12),
    "-",
    "4",
    substr(baseuuid, 13, 15),
    "-",
    sample(c("8", "9", "a", "b"), 1),
    substr(baseuuid, 16, 18),
    "-",
    substr(baseuuid, 19, 30),
    sep = "",
    collapse = ""
  )
}
