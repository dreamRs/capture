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
  document.addEventListener("click", function(e) {
    var el = e.target;
    el.classList.add("disabled");
    if (el.classList.contains("btn-capture-screenshot-pdf") === false) {
      return;
    }

    var toCapture = el.getAttribute("data-selector");
    var fileName = el.getAttribute("data-filename");
    var margins = el.getAttribute("data-margins");

    var node = document.querySelector(toCapture);
    var width = node.clientWidth;
    var height = node.scrollHeight;
    var m = parseInt(margins);
    var ratio = width / height;
    var orientation = ratio > 1 ? "landscape" : "portrait";
    domtoimage
      .toPng(node)
      .then(function(dataUrl) {
        var doc = new window.jspdf.jsPDF({
           orientation: orientation,
           unit: "pt",
           format: [width + m * 2, height + m * 2]
        });
        doc.addImage(dataUrl, "PNG", m, m, width, height);
        doc.save(fileName);
        el.classList.remove("disabled");
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  });
  var count = 1;
  document.addEventListener("click", function(e) {
    var el = e.target;
    el.classList.add("disabled");
    if (el.classList.contains("btn-capture-lookbook-pdf") === false) {
      return;
    }

    var fileName = el.getAttribute("data-filename");
    var node = document.querySelector("body");
    var width = node.clientWidth;
    var height = node.scrollHeight;
    var m = 15;
    var ratio = width / height;
    var orientation = ratio > 1 ? "landscape" : "portrait";
    function filter(node) {
      if (typeof node.classList == "undefined") {
        return(true);
      }
      return(node.classList.contains("panel-capture-lookbook") === false);
    }
    domtoimage
      .toPng(node, {filter: filter})
      .then(function(dataUrl) {
        var doc = new window.jspdf.jsPDF({
           orientation: orientation,
           unit: "pt",
           format: [width + m * 2, height + m * 2]
        });
        doc.addImage(dataUrl, "PNG", m, m, width, height);
        doc.save(fileName + "-" + count + ".pdf");
        count += 1;
        el.classList.remove("disabled");
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  });
})();

