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
