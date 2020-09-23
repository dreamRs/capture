
#' @title Capture Screenshot
#'
#' @description Add a button to take a screenshot of a specified element.
#'
#' @param selector A CSS selector, for example \code{body} to target the whole page or \code{#<ID>} to target a specific output.
#' @param filename Name of the file (without extension) that will be created.
#' @param ... Arguments passed to HTML button.
#' @param format Format of output between: \code{png} or \code{jpeg}.
#'
#' @note It's only possible to take screenshot of elements that are actually visible on screen. It doesn't work in Internet Explorer.
#'
#' @return an HTML tag.
#' @export
#'
#' @importFrom htmltools tagList tags
#' @importFrom tools file_ext
#'
#' @example examples/default.R
capture <- function(selector, filename, ..., format = c("png", "jpeg")) {
  format <- match.arg(format)
  ext <- tools::file_ext(filename)
  if (identical(ext, ""))
    filename <- paste0(filename, ".", format)
  tagList(
    tags$button(
      class = "btn btn-default btn-capture-screenshot",
      `data-selector` = selector,
      `data-filename` = filename,
      ...
    ),
    html_dependency_filesaver(),
    html_dependency_domtoimage()
  )
}

