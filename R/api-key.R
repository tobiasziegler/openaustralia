#' Set the API key
#'
#' This function manually sets an API key that will be used in the current
#' session. Call this function if you haven't set an
#' `OPENAUSTRALIA_API_KEY` environment variable in `~/.Renviron` or
#' if you want to use a different key throughout your current session.
#'
#' Apply for an API key at
#' [the OpenAustralia site](http://www.openaustralia.org.au/api/key).
#'
#' @param api_key a new API key
#'
#' @return Nothing
#' @export
set_api_key <- function(api_key) {
  Sys.setenv(OPENAUSTRALIA_API_KEY = api_key)
}

#' Get the API key
#'
#' Get the current API key set in the `OPENAUSTRALIA_API_KEY` environment
#' variable. If a variable has been set in this session using [set_api_key()]
#' then it will be returned, otherwise a key set in `~/.Renviron` will be
#' returned. If no key has been set then the function will stop with an error.
#'
#' Apply for an API key at
#' [the OpenAustralia site](http://www.openaustralia.org.au/api/key).
#'
#' @return The current API key
#' @export
get_api_key <- function() {
  api_key <- Sys.getenv("OPENAUSTRALIA_API_KEY")

  if (api_key == "") {
    stop("No API key has been set.")
  }

  api_key
}
