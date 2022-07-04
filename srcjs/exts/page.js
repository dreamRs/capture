import { checkIfBrowserSupported, takeScreenshot } from '@xata.io/screenshot';
import { saveAs } from "file-saver";
import * as utils from "../modules/utils";

(function() {
  // IMAGE
  function capurePage(event) {
    var el = event.target;
    if (!utils.elOrParentHasClass(el, "btn-capture-page")) {
      return;
    }
    el = utils.validateEl(el, "btn-capture-page");
    if (!checkIfBrowserSupported()) {
      alert(
        "Screenshot functionnality is not supported."
      );
    }
    el.classList.add("disabled");
    var fileName = el.getAttribute("data-filename");
    var inputId = el.getAttribute("data-inputId");
    
    takeScreenshot()
      .then(function(screenshot) {
        if (fileName !== null) {
          saveAs(screenshot, fileName);
        }
        if (inputId !== null) {
          Shiny.setInputValue(inputId, screenshot);
        }
        el.classList.remove("disabled");
      })
      .catch(function(error) {
        console.error("Capture: oops, something went wrong!", error);
      });
  }
  function capurePage_(event) {
    try {
      capurePage(event);
    } catch (error) {
      console.error(error);
    }
  }
  document.addEventListener("click", capurePage_);
})();
