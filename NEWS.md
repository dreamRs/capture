# capture 0.1.5

* Allow floating numbers in `scale =` argument [#13](https://github.com/dreamRs/capture/issues/13).
* Allow to pass JavaScript function in `options$filter` argument [#12](https://github.com/dreamRs/capture/issues/12).
* Added `loading` parameters to `capture()` like in `capture_pdf()`
* Added `statusInputId` parameter to `capture()` and `capture_pdf()` to retrieve status information in an `input` value server-side.


# capture 0.1.4

* Updated html-to-image to 1.11.11.
* Updated jspdf to 2.5.1.


# capture 0.1.3

* Updated html-to-image to 1.10.8.


# capture 0.1.2

* Use [{packer}](https://github.com/JohnCoene/packer) to manage JavaScript assets.
* Switch [dom-to-image](https://github.com/tsayen/dom-to-image) for [html-to-image](https://github.com/bubkoo/html-to-image).
* `capture()` / `capture_pdf()`: added `button_class` argument, the base CSS class for the button.


# capture 0.1.1

* `capture()` / `capture_pdf()`: added `scale` argument, to be applied to image dimensions.
* `capture()`: added `inputId` argument to allow retrieving image as base64 string server-side.


# capture 0.1.0

* Add a button in web page ('Shiny' or 'RMarkdown') to take a screenshot of a specified element.
* Added a `NEWS.md` file to track changes to the package.
