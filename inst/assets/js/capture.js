/*!
 * Copyright (c) 2020 dreamRs
 *
 * capture, JavaScript bindings to take screenshot of an element of the page
 *
 * @version 0.0.1
 */

/*jshint
  browser:true,
  devel: true
*/
/*global domtoimage */

(function() {
  document.addEventListener("click", function(e) {
    var el = e.target;
    if (el.classList.contains("btn-capture-screenshot") === false) {
      return;
    }
    var toCapture = el.getAttribute("data-selector");
    var node = document.querySelector(toCapture);
    var fileName = el.getAttribute("data-filename");
    var options = el.getAttribute("data-options");
    options = JSON.parse(options);
    domtoimage
      .toBlob(node, options)
      .then(function(blob) {
        window.saveAs(blob, fileName);
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  });
})();

