import { Controller } from "@hotwired/stimulus";
import hljs from "highlight.js/lib/common";

export default class extends Controller {
  connect() {
    this.element.querySelectorAll("pre code").forEach((el) => {
      if (el.classList.contains("hljs")) {
        return;
      }
      hljs.highlightElement(el);
    });
  }
}
