# capture

> Add a button in Shiny application or R Markdown document to take a screenshot (PNG or PDF) of a specified element. It uses [html-to-image](https://github.com/bubkoo/html-to-image) to convert DOM elements to PNG and [jsPDF](https://github.com/parallax/jsPDF) to generate PDF. Doesn't work in IE.

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
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



## Development

This package use [{packer}](https://github.com/JohnCoene/packer) to manage JavaScript assets, see packer's [documentation](https://packer.john-coene.com/#/) for more.

Install nodes modules with:

```r
packer::npm_install()
```

Modify `srcjs/exts/image.js` or `srcjs/exts/pdf.js`, then run:

```r
packer::bundle()
```

Re-install R package and try `capture()` or `capture_pdf()` functions.


