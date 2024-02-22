import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["target", "template"];

  remove(event) {
    event.preventDefault();

    const wrapper = event.target.closest(".slack-account");

    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove();
    } else {
      wrapper.classList.add("hidden");
      wrapper.querySelector("input[name*='_destroy']").value = "true";
    }
  }
}
