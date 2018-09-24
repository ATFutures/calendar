#' Create object of class ical
#'
#' @inheritParams ic_find
#' @export
#' @examples
#' ic <- ical(ical_example)
#' class(ic)
#' attributes(ic)
ical <- function(x) {
  ical_df <- ic_dataframe(x)
  ical_tibble <- tibble::as_data_frame(ical_df)
  class(ical_tibble) <- c("ical", class(ical_tibble))
  attr(ical_tibble, "ical") <- ic_attributes_vec(x)
  ical_tibble
}
#' Extract attributes from ical text
#' @inheritParams ic_find
#' @export
#' @examples
#' ic_attributes_vec(ical_example)
ic_attributes_vec <- function(x) {
  line_first_event <- grep("BEGIN:VEVENT", x)[1]
  x_attributes <- x[1:(line_first_event - 1)]
  ic_vector(x_attributes, pattern = "*")
}
#' Convert ical object to character strings of attributes
#'
#' @param ic object of class `ical`
#' @export
#' @examples
#' ic <- ical(ical_example)
#' ic_character(ic)
#' identical(ical_example, ic_character(ic))
#' # ic_character(ic[c(1, 1), ]) # multiple events
ic_character <- function(ic) {
  char_attributes <- paste(names(attributes(ic)$ical), attributes(ic)$ical, sep = ":")
  char_events <- ic_char_event(ic)
  c(char_attributes, char_events, "END:VCALENDAR")
}
#' Convert ical object to character strings of events
#'
#' @inheritParams ic_character
#' @export
#' @examples
#' ic <- ical(ical_example)
#' ic_char_event(ic)
#' ic_char_event(ic[c(1, 1), ])
ic_char_event <- function(ic) {
  date_cols <- grepl(pattern = "VALUE=DATE", x = names(ic))
  if(any(date_cols)) {
    ic[date_cols] <- lapply(ic[, date_cols], ic_char_date)
  }
  datetime_cols <- names(ic) %in% c("DTSTART", "DTEND")
  if(any(datetime_cols)) {
    ic[datetime_cols] <- lapply(ic[, datetime_cols], ic_char_datetime)
  }
  char_names <- c(rep(c("BEGIN", names(ic), "END"), nrow(ic)))
  char_contents <-  apply(ic, 1, function(x) c("VEVENT", as.character(x), "VEVENT"))
  paste(char_names, char_contents, sep = ":")
}
