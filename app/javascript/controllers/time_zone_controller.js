import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.change();
  }

  change() {
    const timeZone = Intl.DateTimeFormat().resolvedOptions().timeZone;

    if (!this.inputTarget.value) {
      this.inputTarget.value = timeZone
    }

    this.inputTarget.classList.add("border-green-600");
  }
}
