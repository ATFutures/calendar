#' Return a named vector from raw iCal text
#'
#' This is designed to be a helper function for creating data frames
#' ical lists.
#'
#' @inheritParams ic_list
#' @inheritParams ic_find
#' @export
#' @examples
#' x = ical_example[18:19]
#' ic_vector(x)
ic_vector <- function(x, pattern = paste0(ical::properties, collapse = "|")) {
  key <- gsub(pattern = ":(.*)", replacement = "", x = x)
  value <- gsub(pattern = "(.*?):", replacement = "", x = x)
  names(value) <- key
  value <- value[grepl(pattern = pattern, x = names(value))]
  value
  # class(value)
  # data.frame(as.list(value))

  # an alternative approach (abandoned)
  # key_value_df = read.table(text = key_value, sep = ":", row.names = 1, stringsAsFactors = FALSE)
  # key_value_vec = c(key_value_df)
  # class(key_value_vec)
}
