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
