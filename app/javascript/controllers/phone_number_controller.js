import { Controller } from "@hotwired/stimulus";
import intlTelInput from "intl-tel-input";
import I18n from "i18n";
import { VALID_CLASSES, INVALID_CLASSES } from "constants";

const t = I18n("phone_number");
const DEFAULT_COUNTRY_CODE = window.constants.DEFAULT_COUNTRY_CODE;
const ERRORS = {
  0: t("is_possible"),
  1: t("invalid_country_code"),
  2: t("too_short"),
  3: t("too_long"),
  4: t("is_possible_local_only"),
  5: t("invalid_length"),
  "-99": t("invalid_phone_number"),
};

export default class extends Controller {
  static targets = ["input", "error", "hidden"];

  connect() {
    this.iti = intlTelInput(this.inputTarget, {
      utilsScript: "intl-tel-input/build/js/utils.js",
      initialCountry: "auto",
      geoIpLookup: async function (success) {
        try {
          const response = await fetch("/country_codes", {
            method: "POST",
            headers: { Accept: "application/json" },
          });
          const json = await response.json();
          success(json.country_code || DEFAULT_COUNTRY_CODE);
        } catch {
          success(DEFAULT_COUNTRY_CODE);
        }
      },
    });
  }

  disconnect() {
    this.iti = null;
  }

  input() {
    this.hiddenTarget.value = this.iti.getNumber();

    if (this.inputTarget.value.trim() || !this.inputTarget.required) {
      if (this.iti.isValidNumber()) {
        this.errorTarget.innerText = "";
        this.inputTarget.classList.add(...VALID_CLASSES);
        this.inputTarget.classList.remove(...INVALID_CLASSES);
      } else {
        this.errorTarget.innerText = ERRORS[this.iti.getValidationError()];
        this.inputTarget.classList.add(...INVALID_CLASSES);
        this.inputTarget.classList.remove(...VALID_CLASSES);
      }
    } else {
      this.errorTarget.innerText = t("not_present");
      this.inputTarget.classList.add(...INVALID_CLASSES);
      this.inputTarget.classList.remove(...VALID_CLASSES);
    }
  }
}
