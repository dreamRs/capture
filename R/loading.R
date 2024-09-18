
#' Loading indicator to be displayed when generating screenshot
#' 
#' @param text Text to be displayed below loading animation.
#' @param type Type of loading animation.
#' @param color Color for text and loading indicator.
#' @param background Background color.
#' @param size Size (in pixels).
#' @param ... Other arguments.
#'
#' @return a `list` that can be used in [capture()] or [capture_pdf()].
#' @export
#'
loading <- function(text = "Generating PDF, please wait...",
                    type = c("standard", "hourglass", "circle", "arrows", "dots", "pulse"),
                    color = "#246abe",
                    background = "rgba(0,0,0,0.8)",
                    size = "80px",
                    ...) {
  type <- match.arg(type)
  dropNulls(list(
    text = text,
    type = type,
    options = list(
      backgroundColor = background,
      svgSize = size,
      svgColor = color,
      ...
    )
  ))
}

