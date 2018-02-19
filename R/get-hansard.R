#' Fetch all Hansard
#'
#' @param search Fetch the data that contain this term
#' @param person Fetch the data by a particular person ID
#' @param order d for date ordering, r for relevance ordering, p for use by
#'   person
#' @param page Page of results to return
#' @param num Number of results to return
#'
#' @export
get_hansard <- function(search = NULL, person = NULL, order = NULL, page = NULL,
                        num = NULL) {
  getHansard(search, person, order, page, num)
}

#' @rdname get_hansard
getHansard <- function(search = NULL, person = NULL, order = NULL, page = NULL,
                       num = NULL) {
  params <- params_from_call(match.call())
  do.call("call_api", params)
}
