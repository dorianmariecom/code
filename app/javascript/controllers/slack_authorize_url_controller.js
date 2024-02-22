import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "link"];

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
        `https://slack.com`,
      );
    }
  }
}
