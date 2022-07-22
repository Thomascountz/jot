import { Controller } from "@hotwired/stimulus";
import { default as EasyMDE } from "easymde";
import hljs from "highlight.js/lib/common";

export default class extends Controller {
  connect() {
    const editor = new EasyMDE({
      element: this.element,
      minHeight: "250px",
      forceSync: true, // Turbo will cache the textarea and restore
      sideBySideFullscreen: false,
      renderingConfig: {
        codeSyntaxHighlighting: true,
        hljs: hljs, // Use the same highlight.js as renderer
      },
    });

    editor.toggleSideBySide();

    // Prevent turbo from caching the editor which would lead to multiple instances on turbo:load
    document.querySelectorAll(".EasyMDEContainer").forEach((el) => {
      el.setAttribute("data-turbo-cache", "false");
    });
  }
}
