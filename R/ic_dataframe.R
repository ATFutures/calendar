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
#' head(x_df)
ic_dataframe <- function(x) {

  x_list <- ic_list(x)

  # testing:
  # icv1 = ic_vector(x_list[[1]])
  # as.data.frame(as.list(icv1))

  x_list_named <- lapply(x_list, function(x) {
    ic_vector(x)
  })

  length_names = vapply(x_list_named, length, numeric(1))

  if(diff(range(length_names)) == 0) {
    x_df <- do.call(rbind, x_list_named)
    x_df <- as.data.frame(x_df, stringsAsFactors = FALSE)
    } else {
    x_df <- rbind.named.fill(x_list_named)
    }

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
