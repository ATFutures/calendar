#' Read ics file
#'
#' @param file ics file to read
#' @return object of class ics
#' @export
#'
#' @examples
#' f <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' ics_list = ic_readpy(f)
#' ics_list
ic_readpy <- function(file) {

  x = readLines(file)
  f1 = x[c(1:5, 22:37, length(x))]
  .cal = .ics$Calendar(f1)
  # class(.cal)
  events = .cal$events
  # class(events)

  events
}
