import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["target", "template", "remove", "primary"];

  connect() {
    this.update()
  }

  add(event) {
    event.preventDefault();

    const innerHTML = this.templateTarget.innerHTML;
    const content = innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime().toString(),
    );
    this.targetTarget.insertAdjacentHTML("beforebegin", content);
    this.update()
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
    this.update()
  }

  update(event) {
    const visiblePrimaryTargets = this.primaryTargets.filter((primaryTarget) => {
      const parent = primaryTarget.closest(".email-address")
      const destroy = parent.querySelector("input[name*='_destroy']")
      return destroy.value === "false"
    })

    let checked;

    if (event && event.target.checked) {
      checked = event.target
    } else {
      checked = visiblePrimaryTargets.find((primaryTarget) => primaryTarget.checked)
    }

    if (!checked) {
      if (event && event.target === this.primaryTargets[0]) {
        checked = visiblePrimaryTargets[1] || visiblePrimaryTargets[0]
      } else {
        checked = visiblePrimaryTargets[0]
      }
    }

    visiblePrimaryTargets.forEach((primaryTarget) => {
      primaryTarget.checked = primaryTarget === checked
    })

    const visibleRemoveTargets = this.removeTargets.filter((removeTarget) => {
      const parent = removeTarget.closest(".email-address")
      const destroy = parent.querySelector("input[name*='_destroy']")
      return destroy.value === "false"
    })

    this.removeTargets.forEach((removeTarget) => {
      if (visibleRemoveTargets.length > 1) {
        removeTarget.classList.remove("hidden")
      } else {
        removeTarget.classList.add("hidden")
      }
    })
  }
}
