#' Example .ics file on English and Welsh holidays
#'
#' This file is documented at: [gov.uk/government/publications/open-standards-for-government/exchange-of-calendar-events](https://www.gov.uk/government/publications/open-standards-for-government/exchange-of-calendar-events)
#'
#' @examples
#' # dataset was stored as follows:
#' # download.file("https://www.gov.uk/bank-holidays/england-and-wales.ics",
#' # "inst/extdata/england-and-wales.ics")
#' # ics_read(system.file("extdata", "england-and-wales.ics", package = "ical"))
#' # holidays = "holidays"
#' # usethis::use_data(holidays)
"holidays"

#' Minimal example of raw ical file (already read-in from file)
#'
#' See [here](https://calendar.google.com/calendar/ical/9sl1qu3qh2vdnq26bjgvtnos94%40group.calendar.google.com/private-85cbe5d781da1b7efc91e01032cfc264/basic.ics) for the file.
#'
#' @examples
#' # download.file("long_url...", "inst/extdata/example.ics")
#' ic_example = readLines(system.file("extdata", "example.ics", package = "ical"))
#' # usethis::use_data(ic_example)
"ic_example"
