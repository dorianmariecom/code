import "@hotwired/turbo-rails";
import "@hotwired/turbo";
import "controllers";

window.addEventListener("message", (event) => {
  const data = JSON.parse(event.data);

  if (data.config) {
    document.body.classList.add("code-app", `code-app:${data.config.CODE_ENV}`);
  }
});
