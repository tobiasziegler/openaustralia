#' Fetch comments left on OpenAustralia
#'
#' @param tidy Convert the output list to a tidyverse-ready format
#' @param date Fetch the comments for this date
#' @param search Fetch the comments that contain this term
#' @param user_id Fetch the comments by a particular user ID
#' @param pid Fetch the comments made on a particular person ID
#'   (Representative/Senator)
#' @param page Page of results to return
#' @param num Number of results to return
#'
#' @export
get_comments <- function(tidy = TRUE, date = NULL, search = NULL,
                         user_id = NULL, pid = NULL, page = NULL,
                         num = NULL) {
  getComments(tidy, date, search, user_id, pid, page, num)
}

#' @rdname get_comments
getComments <- function(tidy = TRUE, date = NULL, search = NULL,
                        user_id = NULL, pid = NULL, page = NULL,
                        num = NULL) {
  params <- params_from_call(match.call())
  response <- do.call("call_api", params)

  if (!tidy)
    return(response)

  # TODO: Convert list data to tidy format
  response
}
