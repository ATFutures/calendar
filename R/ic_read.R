#' Read ics file
#'
#' @param file ics file to read
#' @return object of class ics
#' @export
#'
#' @examples
#' f <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' ics_df = ic_read(f)
#' head(ics_df)
ic_read <- function(file) {

  x <- readLines(file)

  # from https://stackoverflow.com/questions/43573982/how-to-import-ical-ics-file-in-r
  stopifnot(!any(grepl("^\\s+", x)))
  keyval <- do.call(rbind, regmatches(x, regexpr(":", x, fixed = TRUE), invert = TRUE))
  keyval <- keyval[which.max(keyval[,1]=="BEGIN" & keyval[,2]=="VEVENT"):utils::tail(which(keyval[,1]=="END" & keyval[,2]=="VEVENT"), 1),]
  keyval <- cbind.data.frame(keyval, id=cumsum(keyval[,1]=="BEGIN" & keyval[,2]=="VEVENT"))
  df <- stats::reshape(keyval, timevar="1", idvar="id", direction = "wide")
  # head(df[,c(3,4,9)])

  # do something with the contents
  df
}
