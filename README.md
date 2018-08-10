
[![Travis build status](https://travis-ci.org/ATFutures/ical.svg?branch=master)](https://travis-ci.org/ATFutures/ical)

<!-- README.md is generated from README.Rmd. Please edit that file -->
ical
====

The goal of ical is to work with iCalander (`.ics`) files in R. iCalendar is an open standard for "exchanging calendar and scheduling information between users and computers" described at [icalendar.org](https://icalendar.org/)

Recently the UK Government endorsed the iCal format in a [publication](https://www.gov.uk/government/publications/open-standards-for-government/exchange-of-calendar-events) Open Standards for Government' series. [An example .ics file](https://www.gov.uk/bank-holidays/england-and-wales.ics) is provided by the .gov.uk domain, which shows holidays in England and Wales.

Installation
------------

``` r
devtools::install_github("ATFutures/ical")
```

``` r
library(ical)
```

<!-- You can install the released version of ical from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` r -->
<!-- install.packages("ical") -->
<!-- ``` -->
Example
-------

``` r
ics_file <- system.file("extdata", "england-and-wales.ics", package = "ical")
readLines(ics_file, n = 9) # check it's in the ICS format
#> [1] "BEGIN:VCALENDAR"                     
#> [2] "VERSION:2.0"                         
#> [3] "METHOD:PUBLISH"                      
#> [4] "PRODID:-//uk.gov/GOVUK calendars//EN"
#> [5] "CALSCALE:GREGORIAN"                  
#> [6] "BEGIN:VEVENT"                        
#> [7] "DTEND;VALUE=DATE:20120103"           
#> [8] "DTSTART;VALUE=DATE:20120102"         
#> [9] "SUMMARY:New Year’s Day"
ics_df = ic_read(ics_file) # read it in
head(ics_df) # check the results
#>    id 2.BEGIN 2.DTEND;VALUE=DATE 2.DTSTART;VALUE=DATE
#> 1   1  VEVENT           20120103             20120102
#> 9   2  VEVENT           20120407             20120406
#> 17  3  VEVENT           20120410             20120409
#> 25  4  VEVENT           20120508             20120507
#> 33  5  VEVENT           20120605             20120604
#> 41  6  VEVENT           20120606             20120605
#>                  2.SUMMARY                                     2.UID
#> 1           New Year’s Day ca6af7456b0088abad9a69f9f620f5ac-0@gov.uk
#> 9              Good Friday ca6af7456b0088abad9a69f9f620f5ac-1@gov.uk
#> 17           Easter Monday ca6af7456b0088abad9a69f9f620f5ac-2@gov.uk
#> 25  Early May bank holiday ca6af7456b0088abad9a69f9f620f5ac-3@gov.uk
#> 33     Spring bank holiday ca6af7456b0088abad9a69f9f620f5ac-4@gov.uk
#> 41 Queen’s Diamond Jubilee ca6af7456b0088abad9a69f9f620f5ac-5@gov.uk
#>    2.SEQUENCE        2.DTSTAMP  2.END
#> 1           0 20180806T114130Z VEVENT
#> 9           0 20180806T114130Z VEVENT
#> 17          0 20180806T114130Z VEVENT
#> 25          0 20180806T114130Z VEVENT
#> 33          0 20180806T114130Z VEVENT
#> 41          0 20180806T114130Z VEVENT
```

What class is each column?

``` r
vapply(ics_df, class, character(1))
#>                   id              2.BEGIN   2.DTEND;VALUE=DATE 
#>            "integer"             "factor"             "factor" 
#> 2.DTSTART;VALUE=DATE            2.SUMMARY                2.UID 
#>             "factor"             "factor"             "factor" 
#>           2.SEQUENCE            2.DTSTAMP                2.END 
#>             "factor"             "factor"             "factor"
```

Related projects
----------------

-   A Python package for working with ics files: <https://github.com/C4ptainCrunch/ics.py>
