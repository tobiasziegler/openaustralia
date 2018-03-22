#' Fetch all Hansard
#'
#' @param tidy Convert the output list to a tidyverse-ready format
#' @param search Fetch the data that contain this term
#' @param person Fetch the data by a particular person ID
#' @param order d for date ordering, r for relevance ordering, p for use by
#'   person
#' @param page Page of results to return
#' @param num Number of results to return
#'
#' @export
get_hansard <- function(tidy = TRUE, search = NULL, person = NULL,
                        order = NULL, page = NULL, num = NULL) {
  getHansard(tidy, search, person, order, page, num)
}

#' @rdname get_hansard
getHansard <- function(tidy = TRUE, search = NULL, person = NULL,
                       order = NULL, page = NULL, num = NULL) {
  params <- params_from_call(match.call())
  response <- do.call("call_api", params)

  if (!tidy)
    return(response)

  # TODO: Convert list data to tidy format
  response
}
