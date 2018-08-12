#' Convert raw ical text into a list of items
#'
#' This function breaks-up the iCalendar object into a list.
#' By default it breaks it into events, where the number of events
#' is the number of `BEGIN:VEVENT` event initiation lines
#' (assumes all events start and end with `:VEVENT`),
#' as per the specification (see [ic_spec()]).
#'
#' @inheritParams ic_find
#' @param include_pattern should the pattern be included
#' in the output? `FALSE` by default.
#'
#' @export
#' @examples
#' ic_list(ical_example)
#' ics_file <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' x = readLines(ics_file)
#' ics_list = ic_list(x)
#' ics_list[1:2]
#' ic_list(x, include_pattern = TRUE)[1:2]
ic_list = function(x, pattern = ":VEVENT", include_pattern = FALSE) {
  locations = grepl(pattern = pattern, x = x)
  locations_int = which(locations)
  # lines_event1 = x[locations_int[1]:locations_int[2]]
  list_length = length(locations_int) / 2
  list_seq = seq_len(list_length)
  locations_start = list_seq * 2 - 1
  locations_end = list_seq * 2
  if(include_pattern) {
    lapply(list_seq, function(i) {
      x[locations_int[locations_start[i]]:locations_int[locations_end[i]]]
    })
  } else {
    lapply(list_seq, function(i) {
      x[(locations_int[locations_start[i]] + 1):(locations_int[locations_end[i]] - 1)]
    })
  }
}

