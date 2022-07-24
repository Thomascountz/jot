import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggle"];
  connect() {
    this.toggleCheckClass();
  }

  togglePublic(_event) {
    this.toggleTarget.checked = !this.toggleTarget.checked;
    this.toggleCheckClass();
  }

  toggleCheckClass() {
    if (this.toggleTarget.checked) {
      this.element.classList.add("checked")
    } else {
      this.element.classList.remove("checked")
    }
  }
}
