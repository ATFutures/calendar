% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{formats}
\alias{formats}
\title{Convenient datetime formats}
\format{
An object of class \code{list} of length 8.
}
\usage{
formats
}
\description{
Convenient datetime formats
}
\examples{
formats
formats <- list(
 "ddmmyy"="\%d\%m\%y",
 "ddmmyyyy"="\%d\%m\%Y",
 "ddmmyyyy hh"="\%d\%m\%Y \%H",
 "ddmmyyyy hhmm"="\%d\%m\%Y \%H\%M",
 "yyyy-mm-dd"="\%Y-\%m-\%d",
 "yyyy-mm-dd hh:mm"="\%Y-\%m-\%d \%H:\%M",
 "yyyy-mm-dd hh"="\%Y-\%m-\%d \%H",
 "yy-mm-dd"="\%y-\%m-\%d"
)
# usethis::use_data(datetime_formats)
}
\keyword{datasets}
