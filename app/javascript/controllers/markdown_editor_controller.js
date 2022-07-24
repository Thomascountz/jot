import { Controller } from "@hotwired/stimulus";
import { default as EasyMDE } from "easymde";
import hljs from "highlight.js/lib/common";

export default class extends Controller {
  connect() {
    const editor = new EasyMDE({
      element: this.element,
      // autosave is acting weird. Even when I submit the form, it persists
      // autosave: {
      //   enabled: true,
      //   uniqueId: "markdown-editor",
      // },
      toolbar: ["bold", "italic", "heading", "strikethrough", "|", "quote", "unordered-list", "ordered-list", "|", "preview", "side-by-side", "fullscreen"],
      minHeight: "250px",
      forceSync: true, // Turbo will cache the textarea and restore
      sideBySideFullscreen: false,
      renderingConfig: {
        codeSyntaxHighlighting: true,
        hljs: hljs, // Use the same highlight.js as renderer
      },
    });

    // Prevent turbo from caching the editor which would lead to multiple instances on turbo:load
    document.querySelectorAll(".EasyMDEContainer").forEach((el) => {
      el.setAttribute("data-turbo-cache", "false");
    });
  }
}
