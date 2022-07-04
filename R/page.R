
#' @title Capture Screenshot as Image
#'
#' @description Add a button to take a screenshot of a specified element and download a PNG file.
#'
#' @inheritParams capture
#'
#'
#' @return an HTML tag that can be used in UI or rmarkdown HTML document.
#' @export
#'
#' @importFrom htmltools tagList tags
#' @importFrom tools file_ext
#' @importFrom jsonlite toJSON
#'
#' @example examples/page.R
capture_page <- function(filename,
                         ..., 
                         format = c("png", "jpeg"),
                         inputId = NULL,
                         button_class = "btn btn-default") {
  format <- match.arg(format)
  ext <- tools::file_ext(filename)
  if (identical(ext, ""))
    filename <- paste0(filename, ".", format)
  tagList(
    tags$button(
      class = paste(button_class, "btn-capture btn-capture-page"),
      `data-filename` = filename,
      `data-inputId` = inputId,
      ...
    ),
    html_dependency_capture("page")
  )
}
