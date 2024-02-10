import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["emailAddress", "smtpUserName"];

  change(event) {
    this.emailAddressTarget.value ||= event.target.value;
    this.smtpUserNameTarget.value ||= event.target.value;
  }
}
