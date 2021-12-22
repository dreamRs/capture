import * as htmlToImage from "html-to-image";
import { jsPDF } from "jspdf";
import * as utils from "../modules/utils";

(function() {
  // LOOKBOOK
  var count = 1;
  document.addEventListener("click", function(e) {
    var el = e.target;
    if (!utils.elOrParentHasClass(el, "btn-capture-lookbook-pdf")) {
      return;
    }
    el = utils.validateEl(el, "btn-capture-lookbook-pdf");
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
    htmlToImage
      .toPng(node, { filter: filter })
      .then(function(dataUrl) {
        var doc = new jsPDF({
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

