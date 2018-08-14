#' Convert iCal lines of text into a data frame
#'
#' Returns a data frame
#'
#' @inheritParams ic_find
#'
#' @export
#' @examples
#' ics_file <- system.file("extdata", "england-and-wales.ics", package = "ical")
#' x = readLines(ics_file)
#' x_df = ic_dataframe(x)
#' summary(x_df)
ic_dataframe <- function(x) {
  x_list <- ic_list(x)

  # testing:
  # icv1 = ic_vector(x_list[[1]])
  # as.data.frame(as.list(icv1))

  df_list <- lapply(x_list, function(x) {
    as.data.frame(as.list(ic_vector(x)), stringsAsFactors = FALSE)
  })

  x_df <- do.call(rbind, df_list)
  names(x_df) <- ic_propertynameclean(names(x_df))

  # clever way (too clever)
  # select_dt_cols = grepl(pattern = "DTEND|DTSTART", x = names(x_df))
  # test dates
  # datetest = x_df$DTEND[1:5]
  # as.Date(datetest, format = "%Y%m%d")
  # x_df[select_dt_cols] = apply(x_df[select_dt_cols], 2, as.Date, format = "%Y%m%d")

  # simple way
  x_df$DTEND <- as.Date(x_df$DTEND, format = "%Y%m%d")
  x_df$DTSTART <- as.Date(x_df$DTSTART, format = "%Y%m%d")

  x_df
}

ic_propertynameclean <- function(properties) {
  gsub(pattern = ".VALUE.DATE", replacement = "", properties)
}
