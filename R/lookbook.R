
#' @title Create a lookbook
#'
#' @description Add a button in a draggable panel in an application to take several screenshots at different states of the application.
#'  Then you can easily combine PDF generated to share the look of your application with someone who hasn't access yet.
#'
#' @param filename Filename to use for generated PDF (without extension).
#'
#' @return an HTML tag that can be included in UI.
#' @export
#'
#' @importFrom htmltools tags
#' @importFrom shiny absolutePanel
#' @importFrom tools file_ext
#'
#' @example examples/create-lookbook.R
lookbook <- function(filename) {
  ext <- tools::file_ext(filename)
  if (!identical(ext, "pdf"))
    filename <- paste0(filename, ".pdf")
  shiny::absolutePanel(
    class = "panel panel-primary panel-capture-lookbook",
    style = "z-index: 9999999;",
    draggable = TRUE,
    tags$div(
      class = "panel-body",
      tags$button(
        class = "btn btn-primary btn-block btn-capture btn-capture-lookbook-pdf",
        `data-filename` = filename,
        shiny::icon("camera"), "Take screenshot"
      )
    ),
    html_dependency_capture("lookbook")
  )
}







