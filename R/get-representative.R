#' Fetch a particular member of the House of Representatives
#'
#' @param tidy Convert the output list to a tidyverse-ready format
#' @param id If you know the person ID for the member you want (returned from
#'   get_representatives or elsewhere), this will return data for that person
#' @param division The name of an electoral division; OpenAustralia will try and
#'   work it out from whatever you give them
#' @param always_return For the division option, sets whether to always try and
#'   return a Representative, even if the seat is currently vacant
#'
#' @export
get_representative <- function(tidy = TRUE, id = NULL, division = NULL,
                               always_return = NULL) {
  getRepresentative(tidy, id, division, always_return)
}

#' @rdname get_representative
getRepresentative <- function(tidy = TRUE, id = NULL, division = NULL,
                              always_return = NULL) {
  params <- params_from_call(match.call())
  response <- do.call("call_api", params)

  if (!tidy)
    return(response)

  # If search is based on a division parameter, the API returns a single
  # object. But if given a person ID, the returned object is wrapped in an
  # array. For the former case, the single-member list needs to be nested
  # inside another list to match the list structure expected by the tidying
  # function.
  if (is.null(id)) {
    tidy_members(list(response))
  } else {
    tidy_members(response)
  }
}
