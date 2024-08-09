# script: Utilities
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-08-09
# objective: Generate a set of utility functions
# to reduce repeated coding, and simple tasks.
# script start;

#' Assert truthfulness of conditions before evaluation
#'
#' @description
#' This function is a wrapper of [stopifnot()], [tryCatch()] and
#' [cli::cli_abort()] and asserts the truthfulness of the passed expression(s).
#' @param ... expressions >= 1. If named the names are used
#' as error messages, otherwise R's internal error-messages are thrown
#'
#' @param error_message character. An error message, supports [cli]-formatting.
#' @seealso [stopifnot()], [cli::cli_abort()], [tryCatch()]
#' @keywords internal
#'
#' @returns [NULL] if all statements in ... are [TRUE]
assert <- function(
    ...,
    error_message = NULL) {

  # 1) count number of expressions
  # in the ellipsis - this
  # is the basis for the error-handling
  number_expressions <- ...length()
  named_expressions  <- ...names()


  # 2) if there is more than
  # one expression the condtions
  # will either be stored in an list
  # or pased directly into the tryCatch/stopifnot
  if (number_expressions != 1 & !is.null(named_expressions)){

    # 2.1) store all conditions
    # in a list alongside its
    # names
    conditions <- c(...)

    # 2.2) if !is.null(condition_names) the
    # above condition never gets evaluated and
    # stopped otherwise, if there is errors
    #
    # The condition is the names(list()), and is
    # the error messages written on lhs of the the assert
    # function
    if (all(conditions)) {

      # Stop the funciton
      # here if all conditions
      # are [TRUE]
      return(NULL)

    } else {

      cli::cli_abort(
        message = c(
          "x" = named_expressions[which.min(conditions)]
        ),
        call = sys.call(
          1 - length(sys.calls())
        )
      )

    }

  }

  # 3) if there length(...) == 1 then
  # above will not run, and stopped if anything

  tryCatch(
    expr = {
      eval.parent(
        substitute(
          stopifnot(exprs = ...)
        )
      )
    },
    error = function(error){

      # each error message
      # has a message and call
      #
      # the call will reference the caller
      # by default, so we need the second
      # topmost caller

      cli::cli_abort(
        # 3.1) if the length of expressions
        # is >1, then then the error message
        # is forced to be the internal otherwise
        # the assert function will throw the same error-message
        # for any error.
        message = if (is.null(error_message) || number_expressions != 1)
          error$message else
            error_message,
        call    = sys.call(
          1 - length(sys.calls())
        )
      )

    }
  )

}

# script end;
