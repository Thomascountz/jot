import { Controller } from "@hotwired/stimulus";
import Tagify from "@yaireo/tagify";

export default class extends Controller {
  connect() {
    var controller;
    if (this.element.dataset.tagified == "true") {
      return;
    }

    var tagify = new Tagify(this.element, {
      whitelist: ["#SPACE", "#NASA", "#JPL", "#ESA", "#JWST"],
      enforceWhitelist: false,
      transformTag: (tag) => {
        tag.value = tag.value.toLowerCase();
        if (!tag.value.startsWith("#")) {
          tag.value = tag.value.replace(/^/, "#");
        }
      },
    });

    tagify.on("input", (e) => {
      var value = e.detail.value;

      // Let tagify handle the search instead of making a ton of requests
      if (value.length > 2) {
        return;
      }

      tagify.whitelist = null; // reset the whitelist

      // https://developer.mozilla.org/en-US/docs/Web/API/AbortController/abort
      controller && controller.abort();
      controller = new AbortController();

      // show loading animation and hide the suggestions dropdown
      tagify.loading(true).dropdown.hide();

      fetch("/tags/search.json?q=" + value, {
        signal: controller.signal,
      })
        .then((res) => res.json())
        .then(function (newWhitelist) {
          tagify.whitelist = newWhitelist; // update whitelist Array in-place
          tagify.loading(false).dropdown.show(value); // render the suggestions dropdown
        });
    });

    // Disable the turbo cache until I understand how it's effecting the reload
    document.querySelectorAll(".tagify").forEach((el) => {
      el.setAttribute("data-turbo-cache", "false");
    });

    this.element.dataset.tagified = "true";
  }
}
