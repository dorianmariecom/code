import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["id", "prompt", "input"];

  async create(e) {
    e.preventDefault();

    const id = this.idTarget.value;
    const prompt = this.promptTarget.value;
    const csrfToken = document.querySelector("[name='csrf-token']")?.content;

    const response = await fetch("/prompts", {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ prompt: { program_id: id, prompt } }),
    });

    const json = await response.json();

    this.inputTarget.value = json.prompt.input;
  }
}
