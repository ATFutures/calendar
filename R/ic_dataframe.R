#' Convert iCal lines of text into a data frame
#'
#' Returns a data frame
#'
#' @inheritParams ic_find
#'
#' @export
#' @examples
#' ics_file <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' # ics_file = "https://outlook.office365.com/owa/calendar/63f6c4e85d124df6a20656ade8e71faa@leeds.ac.uk/32e1cb4137f4414b8d7644453ec4b10414316826143036893453/calendar.ics"
#' x = readLines(ics_file)
#' x_df = ic_dataframe(x)
#' summary(x_df)
#'
ic_dataframe <- function(x) {

  x_list <- ic_list(x)

  # testing:
  # icv1 = ic_vector(x_list[[1]])
  # as.data.frame(as.list(icv1))

  x_list_named <- lapply(x_list, function(x) {
    ic_vector(x)
  })

  x_df <- rbind.named.fill(x_list_named)
  names(x_df) <- ic_propertynameclean(names(x_df))

  # clever way (too clever)
  # select_dt_cols = grepl(pattern = "DTEND|DTSTART", x = names(x_df))
  # test dates
  # datetest = x_df$DTEND[1:5]
  # as.Date(datetest, format = "%Y%m%d")
  # x_df[select_dt_cols] = apply(x_df[select_dt_cols], 2, as.Date, format = "%Y%m%d")

  # simple way (may need if(max(ncar)) statement to generalise)
  x_df$DTEND <- as.Date(x_df$DTEND, format = "%Y%m%d")
  x_df$DTSTART <- as.Date(x_df$DTSTART, format = "%Y%m%d")

  x_df
}

ic_propertynameclean <- function(properties) {
  gsub(pattern = ".VALUE.DATE", replacement = "", properties)
}

# source: https://stackoverflow.com/questions/17308551/
rbind.named.fill <- function(x) {
  nam <- sapply(x, names)
  unam <- unique(unlist(nam))
  len <- sapply(x, length)
  out <- vector("list", length(len))
  for (i in seq_along(len)) {
    out[[i]] <- unname(x[[i]])[match(unam, nam[[i]])]
  }
  stats::setNames(as.data.frame(do.call(rbind, out), stringsAsFactors=FALSE), unam)
}
