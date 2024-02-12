import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["target", "template"];

  add(event) {
    event.preventDefault();

    const innerHTML = this.templateTarget.innerHTML;
    const content = innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime().toString(),
    );
    this.targetTarget.insertAdjacentHTML("beforebegin", content);
  }

  remove(event) {
    event.preventDefault();

    const wrapper = event.target.closest(".email-address");

    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove();
    } else {
      wrapper.classList.add("hidden");
      wrapper.querySelector("input[name*='_destroy']").value = "true";
    }
  }
}
