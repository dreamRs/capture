
#' @title Capture Screenshot
#'
#' @description Add a button to take a screenshot of a specified element.
#'
#' @param selector A CSS selector, for example \code{body} to target the whole page or \code{#<ID>} to target a specific ouput.
#' @param filename Name of the file that will be created.
#' @param ... Arguments passed to HTML button.
#'
#' @return an HTML tag.
#' @export
#'
#' @examples
capture <- function(selector, filename, ...) {
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

