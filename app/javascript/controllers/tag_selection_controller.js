import { Controller } from "@hotwired/stimulus";
import Tagify from "@yaireo/tagify";

export default class extends Controller {

  initialize() {
    if (this.element.dataset.tagified == "true") {
      return;
    }

    var tagify = new Tagify(this.element, {
      whitelist: ["#SPACE", "#NASA", "#JPL", "#ESA", "#JWST"],
      enforceWhitelist: false,
      transformTag: (tag) => {
        tag.value = tag.value.toUpperCase();
        if (!tag.value.startsWith("#")) {
          tag.value = tag.value.replace(/^/, "#");
        }
      },
    });

    document.querySelectorAll(".tagify").forEach((el) => {
      el.setAttribute("data-turbo-cache", "false");
    });

    this.element.dataset.tagified = "true";
  }
}
