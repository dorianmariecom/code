import { Controller } from "@hotwired/stimulus";
import { VALID_CLASSES } from "constants";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.change();
  }

  change() {
    const timeZone = Intl.DateTimeFormat().resolvedOptions().timeZone;

    if (!this.inputTarget.value) {
      this.inputTarget.value = timeZone;
    }

    this.inputTarget.classList.add(...VALID_CLASSES);
  }
}
