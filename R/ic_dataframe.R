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
#' ics_file <- system.file("extdata", "england-and-wales.ics", package = "calendar")
#' x = readLines(ics_file)
#' x_df = ic_dataframe(x)
#' head(x_df)
#' x = data.frame(x_df)
#' x_df2 = ic_dataframe(x)
#' identical(x, x_df2)
ic_dataframe <- function(x) {

  if(methods::is(object = x, class2 = "data.frame")) {
    return(x)

  }

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
  datetime_cols <- names(x_df) %in% grep("^DT[A-Z]+$|CREATED|LAST-MODIFIED", names(x_df), value = TRUE) # include any column starting with DT
  tzid_cols <- names(x_df) %in% grep(".*TZID=.*", names(x_df), value = TRUE) # find cols with TZID in name
  timezones <- unlist(regmatches(names(x_df), gregexpr("(?<=TZID=).*", names(x_df), perl = TRUE))) # pull all tzones from col names into vector to apply separately to each column
                                                                                                   # in case different events have differing tzones although
                                                                                                   # think most calendar software only uses single tzone

  if(any(date_cols)) {
    x_df[date_cols] <- lapply(x_df[date_cols], ic_date)
  }

  if(any(datetime_cols)) {
    if (any(tzid_cols)) {
      x_df[tzid_cols] <-  Map(function(x, y) ic_datetime(x, tzone = y), x_df[tzid_cols], timezones) # apply timezones to tzid_cols
      x_df[tzid_cols] <- lapply(x_df[tzid_cols], function(x) {attr(x, "tzone") <- ""; x})           # change tzid_cols to local time zone
      x_df[datetime_cols & !tzid_cols] <- lapply(x_df[datetime_cols & !tzid_cols], ic_datetime)     # set time zone on datetime cols without TZID to local ic_datetime() does this by default
    } else {
      x_df[datetime_cols] <- lapply(x_df[datetime_cols], ic_datetime)
    }
  }
  names(x_df) <- gsub(pattern = ";VALUE=DATE", replacement = "", names(x_df))
  names(x_df) <- gsub(pattern = ";TZID.*", replacement = "", names(x_df))
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
