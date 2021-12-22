
#' HTML dependencies used by capture
#'
#' @return an [htmltools::htmlDependency()].
#' @export
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
#'
#' @name html-dependencies
#'
html_dependency_capture <- function() {
  htmlDependency(
    name = "capture",
    version = "0.1.0",
    src = list(file = "packer"),
    package = "capture",
    script = "capture-image.js"
  )
}

#' @rdname html-dependencies
#' @export
html_dependency_domtoimage <- function() {
  htmlDependency(
    name = "dom-to-image",
    version = "2.6.0",
    src = list(file = "assets"),
    package = "capture",
    script = "dom-to-image/dom-to-image.min.js"
  )
}

#' @rdname html-dependencies
#' @export
html_dependency_filesaver <- function() {
  htmlDependency(
    name = "FileSaver",
    version = "2.0.4",
    src = list(file = "assets"),
    package = "capture",
    script = "FileSaver/FileSaver.min.js"
  )
}

#' @rdname html-dependencies
#' @export
html_dependency_jspdf <- function() {
  htmlDependency(
    name = "jsPDF",
    version = "2.1.1",
    src = list(file = "assets"),
    package = "capture",
    script = "jsPDF/jspdf.umd.min.js"
  )
}
