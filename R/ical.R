#' Create object of class ical
#'
#' @inheritParams ic_find
#' @export
#' @examples
#' ic <- ical(ical_example)
#' class(ic)
#' attributes(ic)
ical <- function(x) {
  ical_df <- ic_dataframe(x)
  ical_tibble <- tibble::as_data_frame(ical_df)
  class(ical_tibble) <- c("ical", class(ical_tibble))
  attr(ical_tibble, "ical") <- ic_attributes_vec(x)
  ical_tibble
}
#' Extract attributes from ical text
#' @inheritParams ic_find
#' @export
#' @examples
#' ic_attributes_vec(ical_example)
ic_attributes_vec <- function(x) {
  line_first_event <- grep("BEGIN:VEVENT", x)[1]
  x_attributes <- x[1:line_first_event]
  ic_attr_vec <- ic_vector(x_attributes, pattern = "*")
}
