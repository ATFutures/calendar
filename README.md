
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
#>            dtstamp
#> 1 20180806T114130Z
#> 2 20180806T114130Z
#> 3 20180806T114130Z
#> 4 20180806T114130Z
#> 5 20180806T114130Z
#> 6 20180806T114130Z
```

What class is each column?

``` r
vapply(ics_df, class, character(1))
#>  dtstamp 
#> "factor"
```

Related projects
----------------

-   A Python package for working with ics files: <https://github.com/C4ptainCrunch/ics.py>
