import "@hotwired/turbo-rails";
import "@hotwired/turbo";
import "controllers";

const updateBorderTopWidth = () => {
  if (localStorage.getItem("codeStatusBarHeight")) {
    document.body.style.borderTopWidth = `${localStorage.getItem("codeStatusBarHeight")}px`;
  }
};

window.addEventListener("message", (event) => {
  const data = JSON.parse(event.data);

  if (data.config) {
    document.body.classList.add("code-app", `code-app:${data.config.CODE_ENV}`);
  }

  if (data.statusBarHeight) {
    localStorage.setItem("codeStatusBarHeight", data.statusBarHeight);
    updateBorderTopWidth();
  }
});

window.addEventListener("load", updateBorderTopWidth);
window.addEventListener("turbo:load", updateBorderTopWidth);
