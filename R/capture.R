
#' @title Capture Screenshot as Image
#'
#' @description Add a button to take a screenshot of a specified element and download a PNG file.
#'
#' @param selector A CSS selector, for example \code{body} to target the whole page or \code{#<ID>} to target a specific output.
#' @param filename Name of the file (without extension) that will be created.
#' @param ... Arguments passed to HTML button.
#' @param format Format of output between: \code{png} or \code{jpeg}.
#' @param options Options passed to \code{domtoimage} method, for example you can use \code{bgcolor} to set background color.
#'
#' @note It's only possible to take screenshot of elements that are actually visible on screen. It doesn't work in Internet Explorer.
#'
#' @return an HTML tag.
#' @export
#'
#' @importFrom htmltools tagList tags
#' @importFrom tools file_ext
#' @importFrom jsonlite toJSON
#'
#' @example examples/default.R
capture <- function(selector, filename, ..., format = c("png", "jpeg"), options = list()) {
  format <- match.arg(format)
  ext <- tools::file_ext(filename)
  if (identical(ext, ""))
    filename <- paste0(filename, ".", format)
  if (length(options) < 1)  {
    options <- "{}"
  } else {
    options <- toJSON(x = options, auto_unbox = TRUE)
  }
  tagList(
    tags$button(
      class = "btn btn-default btn-capture btn-capture-screenshot",
      `data-selector` = selector,
      `data-filename` = filename,
      `data-options` = options,
      ...
    ),
    html_dependency_filesaver(),
    html_dependency_domtoimage(),
    html_dependency_capture()
  )
}




#' @title Capture Screenshot as PDF
#'
#' @description Add a button to take a screenshot of a specified element and download a PDF file.
#'
#' @inheritParams capture
#' @param margins Margins to add to PDF.
#' @param loading Add a loading indicator if taking screenshot take time, see \code{\link{loading}} for usage.
#'
#' @return an HTML tag.
#' @export
#'
#' @importFrom tools file_ext
#' @importFrom htmltools tagList tags
#' @importFrom jsonlite toJSON
#' @importFrom shinybusy html_dependency_notiflix
#'
#' @example examples/pdf.R
capture_pdf <- function(selector, filename, ..., margins = 15, loading = NULL) {
  ext <- tools::file_ext(filename)
  if (!identical(ext, "pdf"))
    filename <- paste0(filename, ".pdf")
  tagList(
    tags$button(
      class = "btn btn-default btn-capture btn-capture-screenshot-pdf",
      `data-selector` = selector,
      `data-filename` = filename,
      `data-margins` = margins,
      `data-loading` = tolower(!is.null(loading)),
      ...,
      if (!is.null(loading)) {
        tags$script(
          type = "application/json",
          `data-for` = "capture-loading-config",
          toJSON(loading, auto_unbox = TRUE)
        )
      }
    ),
    html_dependency_jspdf(),
    html_dependency_domtoimage(),
    html_dependency_capture(),
    html_dependency_notiflix()
  )
}


