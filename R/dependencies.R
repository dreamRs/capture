
#' HTML dependencies used by capture
#'
#' @return an \code{\link[htmltools]{htmlDependency}}.
#' @export
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
#'
#' @name html-dependencies
#'
html_dependency_domtoimage <- function() {
  htmlDependency(
    name = "dom-to-image",
    version = "2.6.0",
    src = list(file = "assets"),
    package = "capture",
    script = c(
      "dom-to-image/dom-to-image.min.js",
      "js/capture.js"
    )
  )
}
