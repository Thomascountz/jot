import { Controller } from "@hotwired/stimulus";
import { default as EasyMDE } from "easymde";
import hljs from "highlight.js/lib/common";
import marked from 'marked'

export default class extends Controller {
  connect() {

    // Ensure rendered images' widths are capped in preview
    const renderer = new marked.Renderer();
    renderer.image = function (href, title, text) {
      return `<img src="${href}" alt="${text}" title="${title}" style="max-width:100%;" />`;
    }

    new EasyMDE({
      element: this.element,
      minHeight: "100px",
      forceSync: true, // Turbo will cache the textarea and restore
      sideBySideFullscreen: false,
      renderingConfig: {
        codeSyntaxHighlighting: true,
        hljs: hljs, // Use the same highlight.js as renderer
        markedOptions: {
          renderer: renderer
        }
      },
    });

    // Prevent turbo from caching the editor which would lead to multiple instances on turbo:load
    document.querySelectorAll(".EasyMDEContainer").forEach((el) => {
      el.setAttribute("data-turbo-cache", "false");
    });
  }
}
