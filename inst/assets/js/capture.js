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
  function elOrParentHasClass(element, classname) {
    if (
      typeof element.classList !== "undefined" &&
      element.classList.contains(classname)
    )
      return true;
    return (
      element.parentNode && elOrParentHasClass(element.parentNode, classname)
    );
  }
  function validateEl(element, classname) {
    if (
      typeof element.classList !== "undefined" &&
      element.classList.contains(classname)
    )
      return element;
    return (
      validateEl(element.parentNode, classname)
    );
  }

  // IMAGE
  document.addEventListener("click", function(e) {
    var el = e.target;
    if (!elOrParentHasClass(el, "btn-capture-screenshot")) {
      return;
    }
    el = validateEl(el, "btn-capture-screenshot");
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");
    if (msie > 0 || !!ua.match(/Trident.*rv\:11\./)) {
      alert(
        "Screenshot functionnality is not available with Internet Explorer."
      );
      return;
    }
    el.classList.add("disabled");
    var toCapture = el.getAttribute("data-selector");
    var node = document.querySelector(toCapture);
    var fileName = el.getAttribute("data-filename");
    var scale = parseInt(el.getAttribute("data-scale"));
    var options = el.getAttribute("data-options");
    options = JSON.parse(options);
    if (!isNaN(scale)) {
      options.height = options.height ? options.height * scale : node.offsetHeight * scale;
      options.width = options.width ? options.width * scale : node.offsetWidth * scale;
      if (!options.hasOwnProperty("style")) {
        options.style = {};
      }
      options.style.transform = "scale(" + scale + ")";
      options.style.transformOrigin = "top left";
      options.style.width = node.offsetWidth + "px";
      options.style.height = node.offsetHeight + "px";
    }

    domtoimage
      .toBlob(node, options)
      .then(function(blob) {
        window.saveAs(blob, fileName);
        el.classList.remove("disabled");
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  });

  // PDF
  document.addEventListener("click", function(e) {
    var el = e.target;
    if (!elOrParentHasClass(el, "btn-capture-screenshot-pdf")) {
      return;
    }
    el = validateEl(el, "btn-capture-screenshot-pdf");
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");
    if (msie > 0 || !!ua.match(/Trident.*rv\:11\./)) {
      alert(
        "Screenshot functionnality is not available with Internet Explorer."
      );
      return;
    }
    el.classList.add("disabled");

    var toCapture = el.getAttribute("data-selector");
    var fileName = el.getAttribute("data-filename");
    var margins = el.getAttribute("data-margins");
    var loading = el.getAttribute("data-loading");
    if (loading === "true") {
      var configLoading = el.querySelector(
        "script[data-for='capture-loading-config']"
      );
      configLoading = JSON.parse(configLoading.innerHTML);
      //console.log(configLoading.type);
      Notiflix.Loading.Init(configLoading.options);
      Notiflix.Loading[configLoading.type](configLoading.text);
    }

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
        Notiflix.Loading.Remove();
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  });

  // LOOKBOOK
  var count = 1;
  document.addEventListener("click", function(e) {
    var el = e.target;
    if (!elOrParentHasClass(el, "btn-capture-lookbook-pdf")) {
      return;
    }
    el = validateEl(el, "btn-capture-lookbook-pdf");
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");
    if (msie > 0 || !!ua.match(/Trident.*rv\:11\./)) {
      alert(
        "Screenshot functionnality is not available with Internet Explorer."
      );
      return;
    }
    el.classList.add("disabled");
    var fileName = el.getAttribute("data-filename");
    var node = document.querySelector("body");
    var width = node.clientWidth;
    var height = node.scrollHeight;
    var m = 15;
    var ratio = width / height;
    var orientation = ratio > 1 ? "landscape" : "portrait";
    function filter(node) {
      if (typeof node.classList == "undefined") {
        return true;
      }
      return node.classList.contains("panel-capture-lookbook") === false;
    }
    domtoimage
      .toPng(node, { filter: filter })
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

