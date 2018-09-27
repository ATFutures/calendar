#' Example ics file on English and Welsh holidays
#'
#' This file is documented at
#' https://www.gov.uk/government/publications/open-standards-for-government/exchange-of-calendar-events
#'
#' @examples
#' # dataset was stored as follows:
#' u = "https://www.gov.uk/bank-holidays/england-and-wales.ics"
#' # download.file(u, "inst/extdata/england-and-wales.ics")
#' # holidays = "holidays"
"holidays"

#' Minimal example of raw ical data
#'
#' See https://calendar.google.com/calendar/ical/9sl1qu3qh2vdnq26bjgvtnos94%40group.calendar.google.com/private-85cbe5d781da1b7efc91e01032cfc264/basic.ics for the file
#'
#' @examples
#' # download.file("long_url", "inst/extdata/example.ics")
#' ical_example = readLines(system.file("extdata", "example.ics", package = "ical"))
#' # usethis::use_data(ical_example)
"ical_example"

#' Example of event data with multi-line description from Outlook
#'
#' See [here](https://outlook.office365.com/owa/calendar/63f6c4e85d124df6a20656ade8e71faa@leeds.ac.uk/32e1cb4137f4414b8d7644453ec4b10414316826143036893453/calendar.ics).
#'
#' @examples
#' # ical_outlook_raw <- readLines(long_url)
#' # ical_outlook_list <- ic_list(ical_outlook_raw)
#' # ical_outlook <- ical_outlook_list[1:2]
#' # ical_outlook[[2]][c(1:38)] <- gsub("a|e|i|o|f|l|t|n|b", "a", ical_outlook[[2]][c(1:38)])
#' # ical_outlook[[2]] <- ical_outlook[[2]][c(1, 5, 35, 36:55)]
#' # usethis::use_data(ical_outlook)
"ical_outlook"

#' The key 'properties' that are allowed in ical files
#'
#' @examples
#' # doc = ic_spec(mode = "read")
#' # key_locations = grepl(pattern = " \\| [A-Z]", x = doc)
#' # summary(key_locations)
#' # doc_key = doc[key_locations]
#' # # regexplain::regex_gadget(text = doc_key) # explore
#' # key_properties = grepl(pattern = "3.7|3.8", x = doc)
#' # doc_properties = doc[key_locations & key_properties]
#' # # regexplain::regex_gadget(text = doc_properties) # explore
#' # properties = regmatches(doc_properties, regexpr('[A-Z][A-Z]+', doc_properties))
#' # usethis::use_data(properties)
"properties"

#' The key 'properties' that are allowed in ical files
#'
#' @examples
#' properties_core = list(
#' "UID"="UID",
#' "DTSTART"="DTSTART",
#' "DTEND"="DTEND",
#' "SUMMARY"="SUMMARY"
#' )
"properties_core"

#' ical default VCALENDAR properties in one line vectors.
#'
#' @examples
#' # properties_ical <- ical_example[1:5]
#' # properties_ical
#' # properties_ical[2] <- "PRODID:-//ATFutures/ical //EN"
#' # usethis::use_data(properties_ical)
"properties_ical"

#' Convenient datetime formats
#'
#'
#' @examples
#' formats
#' formats <- list(
#'  "ddmmyy"="%d%m%y",
#'  "ddmmyyyy"="%d%m%Y",
#'  "ddmmyyyy hh"="%d%m%Y %H",
#'  "ddmmyyyy hhmm"="%d%m%Y %H%M"
#' )
#' # usethis::use_data(datetime_formats)
"formats"
