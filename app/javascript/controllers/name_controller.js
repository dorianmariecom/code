import { Controller } from "@hotwired/stimulus";

import I18n from "../i18n";

const t = I18n("name");

const EMAIL_ADDRESS_REGEXP = window.constants.EMAIL_ADDRESS_REGEXP;

export default class extends Controller {
  static targets = ["input", "error"];

  input() {
    if (!this.inputTarget.value && this.inputTarget.required) {
      this.errorTarget.innerText = t("not_present");
      this.inputTarget.classList.add("border-red-600");
      this.inputTarget.classList.remove("border-green-600");
    } else {
      this.errorTarget.innerText = "";
      this.inputTarget.classList.add("border-green-600");
      this.inputTarget.classList.remove("border-red-600");
    }
  }
}
