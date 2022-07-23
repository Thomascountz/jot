import { Controller } from "@hotwired/stimulus";
import Tagify from "@yaireo/tagify";

export default class extends Controller {
  connect() {
    if (this.element.dataset.tagified == "true") {
      return;
    }

    new Tagify(this.element, {
      whitelist: [
        "#SPACE",
        "#NASA",
        "#JPL",
        "#ESA",
        "#JWST",
      ],
      enforceWhitelist: false,
      transformTag: (tag) => {
        tag.value = tag.value.toUpperCase();
        if (!tag.value.startsWith("#")) {
          tag.value = tag.value.replace(/^/, "#");
        }
      }
    });

    this.element.dataset.tagified = "true";
  }
}
