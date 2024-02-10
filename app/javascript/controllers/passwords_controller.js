import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["target", "template", "remove"];

  connect() {
    this.update();
  }

  add(event) {
    event.preventDefault();

    const innerHTML = this.templateTarget.innerHTML;
    const content = innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime().toString(),
    );
    this.targetTarget.insertAdjacentHTML("beforebegin", content);
    this.update();
  }

  remove(event) {
    event.preventDefault();

    const wrapper = event.target.closest(".password");

    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove();
    } else {
      wrapper.classList.add("hidden");
      wrapper.querySelector("input[name*='_destroy']").value = "true";
    }
    this.update();
  }

  update(event) {
    const visibleRemoveTargets = this.removeTargets.filter((removeTarget) => {
      const parent = removeTarget.closest(".password");
      const destroy = parent.querySelector("input[name*='_destroy']");
      return destroy.value === "false";
    });

    this.removeTargets.forEach((removeTarget) => {
      if (visibleRemoveTargets.length > 1) {
        removeTarget.classList.remove("hidden");
      } else {
        removeTarget.classList.add("hidden");
      }
    });
  }
}
