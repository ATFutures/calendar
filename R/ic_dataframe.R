#' Convert iCal lines of text into a data frame
#'
#' Returns a data frame
#'
#' @inheritParams ic_find
#'
#' @export
#' @examples
#' ic_dataframe(ical_example)
#' ic_dataframe(ical_outlook)
#' ics_file <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' x = readLines(ics_file)
#' x_df = ic_dataframe(x)
#' head(x_df)
ic_dataframe <- function(x) {

  stopifnot(methods::is(object = x, class2 = "character") | methods::is(object = x, class2 = "list"))

  if(methods::is(object = x, class2 = "character")) {
    x_list <- ic_list(x)
  } else if(methods::is(object = x, class2 = "list")) {
    x_list <- x
  }

  x_list_named <- lapply(x_list, function(x) {
    ic_vector(x)
  })
  x_df <- ic_bind_list(x_list_named)

  date_cols <- grepl(pattern = "VALUE=DATE", x = names(x_df))
  if(any(date_cols)) {
    x_df[date_cols] <- lapply(x_df[, date_cols], ic_date)
  }
  datetime_cols <- names(x_df) %in% c("DTSTART", "DTEND")
  if(any(datetime_cols)) {
    x_df[datetime_cols] <- lapply(x_df[, datetime_cols], ic_datetime)
  }

  # names(x_df) <- gsub(pattern = ".VALUE.DATE", replacement = "", names(x_df))

  x_df
}

#' Bind list of named vectors of variable length into data frame
#'
#' Based on: https://stackoverflow.com/questions/17308551/
#'
#' @param x list of named vectors
#' @export
#' @examples
#' ic_bind_list(list(ic_vector(ical_example)))
#' ics_file <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' ics_raw = readLines(ics_file)
#' x <- lapply(ic_list(ics_raw), function(x) {
#'   ic_vector(x)
#' })
#' ic_df <- ic_bind_list(x)
#' head(ic_df)
#' x <- lapply(ical_outlook, function(x) {
#'   ic_vector(x)
#' })
#' ic_bind_list(x)
ic_bind_list <- function(x) {
  nam <- lapply(x, names)                             # list of names of each VEVENT
  unam <- unique(unlist(nam))                         # unique list of EVERY VEVENT
  len <- vapply(x, length, integer(1))                # vector of length of each VEVENT from nam
  out <- vector("list", length(len))                  # placeholder for all VEVENTS
  for (i in seq_along(len)) {
    out[[i]] <- unname(x[[i]])[match(unam, nam[[i]])] # find indices of unique names in each VEVENT and subset unnamed x[[i]] with it.
  }
  # create the dataframe from the columns of VEVENT properties and name the columns
  stats::setNames(as.data.frame(do.call(rbind, out), stringsAsFactors=FALSE), unam)
}
