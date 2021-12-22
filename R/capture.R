
#' @title Capture Screenshot as Image
#'
#' @description Add a button to take a screenshot of a specified element and download a PNG file.
#'
#' @param selector A CSS selector, for example `body` to target the whole page or `#<ID>` to target a specific output.
#' @param filename Name of the file (without extension) that will be created. If `NULL` no file is downloaded client side.
#' @param ... Arguments passed to HTML button.
#' @param format Format of output between: `"png"` or `"jpeg"`.
#' @param scale Scale factor applied to image's dimension. Can be used to get a higher resolution image.
#' @param inputId An `inputId` to retrieve image as base64 in an `input` slot server-side.
#' @param options Options (as a list) passed to [domtoimage](https://github.com/tsayen/dom-to-image)
#'  method, for example you can use `bgcolor` to set background color.
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
capture <- function(selector,
                    filename,
                    ..., 
                    format = c("png", "jpeg"),
                    scale = NULL, 
                    inputId = NULL,
                    options = NULL) {
  format <- match.arg(format)
  ext <- tools::file_ext(filename)
  if (identical(ext, ""))
    filename <- paste0(filename, ".", format)
  tagList(
    tags$button(
      class = "btn btn-default btn-capture btn-capture-screenshot",
      `data-selector` = selector,
      `data-filename` = filename,
      `data-options` = toJSON(x = options, auto_unbox = TRUE),
      `data-scale` = scale,
      `data-inputId` = inputId,
      ...
    ),
    html_dependency_capture()
  )
}




#' @title Capture Screenshot as PDF
#'
#' @description Add a button to take a screenshot of a specified element and download a PDF file.
#'
#' @inheritParams capture
#' @param margins Margins to add to PDF.
#' @param loading Add a loading indicator if taking screenshot take time, see [loading()] for usage.
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
capture_pdf <- function(selector, filename, ..., margins = 15, loading = NULL, scale = NULL, options = list()) {
  ext <- tools::file_ext(filename)
  if (!identical(ext, "pdf"))
    filename <- paste0(filename, ".pdf")
  if (length(options) < 1)  {
    options <- "{}"
  } else {
    options <- toJSON(x = options, auto_unbox = TRUE)
  }
  tagList(
    tags$button(
      class = "btn btn-default btn-capture btn-capture-screenshot-pdf",
      `data-selector` = selector,
      `data-filename` = filename,
      `data-margins` = margins,
      `data-loading` = tolower(!is.null(loading)),
      `data-options` = options,
      `data-scale` = if (!is.null(scale)) scale,
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


