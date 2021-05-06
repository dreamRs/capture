# capture

> Add a button in Shiny application or R Markdown document to take a screenshot (PNG or PDF) of a specified element. It uses [dom-to-image](https://github.com/tsayen/dom-to-image) to convert DOM elements to PNG and [jsPDF](https://github.com/MrRio/jsPDF) to generate PDF. Doesn't work in IE.

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build status](https://github.com/dreamRs/capture/workflows/R-CMD-check/badge.svg)](https://github.com/dreamRs/capture/actions)
<!-- badges: end -->



## Installation

You can install the development version of {capture} from GitHub with:

```r
remotes::install_github("dreamRs/capture")
```

## Features

Take screenshots in your [{shiny}](https://shiny.rstudio.com/) applications and [{rmarkdown}](https://rmarkdown.rstudio.com/) documents.

* `capture()`: save as PNG
* `capture_pdf()`: save as PDF


## Example

In UI, use `capture()` to save element of the page as PNG:

```r
fluidPage(

  capture::capture(
    selector = "body",
    filename = "all-page.png",
    icon("camera"), "Take screenshot of all page"
  )
  
  # ...
  
)
```

You can create PDF document of the page with `capture_pdf()`.



## Related packages

* [shinyscreenshot](https://github.com/daattali/shinyscreenshot) (on CRAN): Capture screenshots of entire pages or parts of pages in Shiny apps
* [snapper](https://github.com/yonicd/snapper) : snap images of html objects in Shiny apps using `canvas2html` JavaScript
library.

