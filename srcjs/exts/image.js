import * as htmlToImage from "html-to-image";
import { saveAs } from "file-saver";
import * as utils from "../modules/utils";
import { Loading } from "notiflix/build/notiflix-loading-aio";

(function() {
  // IMAGE
  function capureImage(event) {
    var el = event.target;
    if (!utils.elOrParentHasClass(el, "btn-capture-screenshot")) {
      return;
    }
    el = utils.validateEl(el, "btn-capture-screenshot");
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
    var inputId = el.getAttribute("data-inputId");
    var scale = parseFloat(el.getAttribute("data-scale"));
    var options = el.getAttribute("data-options");
    var loading = el.getAttribute("data-loading");
    var statusId = el.getAttribute("data-status-id");
    if (statusId !== null) {
      Shiny.setInputValue(statusId, {status: "started", timestamp: Date.now()});
    }
    if (loading === "true") {
      var configLoading = el.querySelector(
        "script[data-for='capture-loading-config']"
      );
      configLoading = JSON.parse(configLoading.innerHTML);
      //console.log(configLoading.type);
      Loading.init(configLoading.options);
      Loading[configLoading.type](configLoading.text);
    }
    options = JSON.parse(options);
    if (options.hasOwnProperty("filter")) {
      options.filter = eval("(" + options.filter + ")");
    }
    if (!isNaN(scale)) {
      options.height = options.height
        ? options.height * scale
        : node.offsetHeight * scale;
      options.width = options.width
        ? options.width * scale
        : node.offsetWidth * scale;
      if (!options.hasOwnProperty("style")) {
        options.style = {};
      }
      options.style.transform = "scale(" + scale + ")";
      options.style.transformOrigin = "top left";
      options.style.width = node.offsetWidth + "px";
      options.style.height = node.offsetHeight + "px";
    }
    htmlToImage
      .toBlob(node, options)
      .then(function(blob) {
        if (fileName !== null) {
          saveAs(blob, fileName);
        }
        if (inputId !== null) {
          var reader = new FileReader();
          reader.readAsDataURL(blob);
          reader.onloadend = function() {
            var base64data = reader.result;
            Shiny.setInputValue(inputId, base64data);
          };
        }
        el.classList.remove("disabled");
        Loading.remove();
        if (statusId !== null) {
          Shiny.setInputValue(statusId, {status: "finished", timestamp: Date.now()});
        }
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  }
  function capureImage_(event) {
    try {
      capureImage(event);
    } catch (error) {
      console.error(error);
    }
  }
  document.addEventListener("click", capureImage_);
})();

