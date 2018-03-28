#' Fetch a particular Senator
#'
#' @param tidy Convert the output list to a tidyverse-ready format
#' @param id If you know the person ID for the Senator you want, this will
#'   return data for that person
#'
#' @export
get_senator <- function(tidy = TRUE, id = NULL) {
  getSenator(tidy, id)
}

#' @rdname get_senator
getSenator <- function(tidy = TRUE, id = NULL) {
  params <- params_from_call(match.call())
  response <- do.call("call_api", params)

  if (!tidy)
    return(response)

  tidy_members(response)
}
