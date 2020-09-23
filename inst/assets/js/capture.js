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
  function download(filename, dataImage) {
    var element = document.createElement("a");
    element.setAttribute("href", dataImage);
    element.setAttribute("download", filename);

    element.style.display = "none";
    document.body.appendChild(element);

    element.click();

    document.body.removeChild(element);
  }

  document.addEventListener("click", function(e) {
    var el = e.target;
    if (el.classList.contains("btn-capture-screenshot") === false) {
      return;
    }
    var toCapture = el.getAttribute("data-selector");
    var node = document.querySelector(toCapture);
    var fileName = el.getAttribute("data-filename");
    domtoimage
      .toPng(node)
      .then(function(dataUrl) {
        download(fileName, dataUrl);
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  });
})();

