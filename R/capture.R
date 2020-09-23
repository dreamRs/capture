
#' @title Capture Screenshot
#'
#' @description Add a button to take a screenshot of a specified element.
#'
#' @param selector A CSS selector, for example \code{body} to target the whole page or \code{#<ID>} to target a specific output.
#' @param filename Name of the file that will be created.
#' @param ... Arguments passed to HTML button.
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
capture <- function(selector, filename, ...) {
  ext <- tools::file_ext(filename)
  if (!identical(ext, "png"))
    filename <- paste0(filename, ".png")
  tagList(
    tags$button(
      class = "btn btn-default btn-capture-screenshot",
      `data-selector` = selector,
      `data-filename` = filename,
      ...
    ),
    html_dependency_domtoimage()
  )
}

