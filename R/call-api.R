#' Call the API directly
#'
#' All the other functions call this one - it's exported only
#' for debugging purposes - so use them instead.
#'
#' If you're really curious about implementation, read on.
#' Each API function introspects to see what its function name
#' is, bundles up its named arguments, and calls this function with them.
#' Consequently, aside from a bit of argument checking and/or return value
#' massaging, every function is implemented exactly the same way.
#'
#' @param endpoint Function name e.g. 'getConstituencies'
#' @param ... \code{endpoint}'s (often optional) named arguments
#'
#' @return Response content, as unserialized by \code{jsonlite::fromJSON}
#' @export
call_api <- function(endpoint, ...) {
  # Build the query parameters from the arguments passed into this function
  q <- list(...)
  if (length(q) > 0) {
    q <- q[sapply(q, function(x) !is.null(x))] # remove NULL values
  }

  q$output <- "js"
  q$key <- get_api_key()

  openaustralia_url <- "http://www.openaustralia.org.au/api/"
  # Set the user agent to identify the client in API requests
  ua <- httr::user_agent("https://github.com/tobiasziegler/openaustralia")

  response <- httr::GET(
    paste0(openaustralia_url, endpoint),
    query = q,
    ua
  )

  # Catch any HTTP errors, e.g. server problems
  if (httr::http_error(response)) {
    stop(
      sprintf(
        "OpenAustralia API request failed [%s]",
        httr::http_status(response)$message
      ),
      call. = FALSE
    )
  }

  if (!(httr::http_type(response) %in%
    c("text/javascript", "application/json"))) {
    stop("API did not return a JavaScript object", call. = FALSE)
  }
  # The server actually offers text/javascript; ; charset=iso-8859-1 :-/

  content <- httr::content(response)
  robj <- jsonlite::fromJSON(
    content,
    simplifyVector = FALSE
    )

  # API errors return 200 but provide a field in the json
  if ("error" %in% names(robj)) {
    stop(robj$error)
  }

  robj
}

params_from_call <- function(mcall) {
  lst <- as.list(mcall)
  lst$endpoint <- deparse(lst[[1]]) # add endpoint to list
  lst$tidy <- NULL # remove the non-API-related tidy element
  lst[2:length(lst)] # remove specious unnamed first element
}
