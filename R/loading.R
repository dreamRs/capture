
#' Loading indicator to be displayed when generating screenshot
#'
#' @param text Text to be displayed below loading animation.
#' @param type Type of loading animation.
#' @param color Color.
#' @param background Background color.
#' @param size Size (in pixels).
#' @param ... Other arguments.
#'
#' @return a \code{list} that can be used in \code{capture_pdf}.
#' @export
#'
loading <- function(text = "Generating PDF, please wait...",
                    type = c("standard", "hourglass", "circle", "arrows", "dots", "pulse"),
                    color = "#246abe",
                    background = "rgba(0,0,0,0.8)",
                    size = "80px",
                    ...) {
  type <- match.arg(type)
  type <- tools::toTitleCase(type)
  list(
    text = text,
    type = type,
    options = list(
      backgroundColor = background,
      svgSize = size,
      svgColor = color,
      ...
    )
  )
}

