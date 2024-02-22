import { Controller } from "@hotwired/stimulus";
import I18n from "i18n";
import { VALID_CLASSES, INVALID_CLASSES } from "constants";

const t = I18n("slack_authorize_url");

const SLACK_TEAM_REGEXP = window.constants.SLACK_TEAM_REGEXP;

export default class extends Controller {
  static targets = ["input", "link", "error"];

  input() {
    const team = this.inputTarget.value;
    let href = this.linkTarget.href;

    if (team) {
      if (href.startsWith("https://slack.com")) {
        this.linkTarget.href = href.replace(
          "https://slack.com",
          `https://${team}.slack.com`,
        );
      } else {
        this.linkTarget.href = href.replace(
          /https:\/\/.+\.slack\.com/,
          `https://${team}.slack.com`,
        );
      }
    } else {
      this.linkTarget.href = href.replace(
        /https:\/\/.*slack\.com/,
        "https://slack.com",
      );
    }

    if (!this.inputTarget.value && this.inputTarget.required) {
      this.errorTarget.innerText = t("not_present");
      this.inputTarget.classList.add(...INVALID_CLASSES);
      this.inputTarget.classList.remove(...VALID_CLASSES);
    } else if (
      this.inputTarget.value &&
      !this.inputTarget.value.match(SLACK_TEAM_REGEXP)
    ) {
      this.errorTarget.innerText = t("not_valid");
      this.inputTarget.classList.add(...INVALID_CLASSES);
      this.inputTarget.classList.remove(...VALID_CLASSES);
    } else {
      this.errorTarget.innerText = "";
      this.inputTarget.classList.add(...VALID_CLASSES);
      this.inputTarget.classList.remove(...INVALID_CLASSES);
    }
  }
}
