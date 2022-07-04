
#' HTML dependencies used by capture
#' 
#' @param type Type of dependency to use.
#'
#' @return an [htmltools::htmlDependency()].
#' @export
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
#'
#' @name html-dependencies
#'
html_dependency_capture <- function(type = c("image", "pdf", "lookbook", "page")) {
  type <- match.arg(type)
  htmlDependency(
    name = "capture",
    version = "0.1.0",
    src = list(file = "packer"),
    package = "capture",
    script = sprintf("capture-%s.js", type)
  )
}
