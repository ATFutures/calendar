#' Read ics file
#'
#' @param file ics file to read
#' @return object of class ics
#' @export
#'
#' @examples
#' f <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' ic_read(f)
ic_read <- function(file) {
  # TODO: type check & stop
  contents <- readLines(file)
  # do something with the contents
  contents[1]
}
