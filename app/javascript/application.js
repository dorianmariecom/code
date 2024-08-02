import "@hotwired/turbo-rails";
import "@hotwired/turbo";
import "controllers";

const updateBorderTopWidth = () => {
  if (localStorage.getItem("codeStatusBarHeight")) {
    document.body.style.borderTopWidth = `${localStorage.getItem("codeStatusBarHeight")}px`;
  }
};

const sendTokens = () => {
  window.ReactNativeWebView.postMessage(
    JSON.stringify({ tokens: window.code.tokens }),
  );
};

window.addEventListener("load", sendTokens);
window.addEventListener("load", updateBorderTopWidth);
window.addEventListener("turbo:load", sendTokens);
window.addEventListener("turbo:load", updateBorderTopWidth);
window.addEventListener("message", (event) => {
  const data = JSON.parse(event.data);

  if (data.config) {
    document.body.classList.add("code-app", `code-app:${data.config.CODE_ENV}`);
  }

  if (data.statusBarHeight) {
    localStorage.setItem("codeStatusBarHeight", data.statusBarHeight);
    updateBorderTopWidth();
  }

  if (data.device && !window.code.deviceTokens.includes(data.device.token)) {
    const csrfToken = document.querySelector("[name='csrf-token']")?.content;

    fetch("/devicees", {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ device: data.device }),
    });

    window.location.reload();
  }
});
