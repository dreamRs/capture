import * as htmlToImage from "html-to-image";
import { jsPDF } from "jspdf";
import { Loading } from "notiflix/build/notiflix-loading-aio";
import * as utils from "./utils";

(function() {
  // PDF
  function capturePDF(event) {
    var el = event.target;
    if (!utils.elOrParentHasClass(el, "btn-capture-screenshot-pdf")) {
      return;
    }
    el = utils.validateEl(el, "btn-capture-screenshot-pdf");
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
      Loading.init(configLoading.options);
      Loading[configLoading.type](configLoading.text);
    }
    
    var node = document.querySelector(toCapture);
    var width = node.clientWidth;
    var height = node.scrollHeight;
    var m = parseInt(margins);
    var ratio = width / height;
    var orientation = ratio > 1 ? "landscape" : "portrait";
    
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
    
    htmlToImage
      .toPng(node, options)
      .then(function(dataUrl) {
        var doc = new jsPDF({
          orientation: orientation,
          unit: "pt",
          format: [width + m * 2, height + m * 2]
        });
        doc.addImage(dataUrl, "PNG", m, m, width, height);
        doc.save(fileName);
        el.classList.remove("disabled");
        Loading.remove();
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  }
  function capturePDF_(event) {
    try {
      capturePDF(event);
    } catch (error) {
      console.error(error);
    }
  }
  document.addEventListener("click", capturePDF_);
})();

