// @hotwired/turbo@8.0.5 downloaded from https://ga.jspm.io/npm:@hotwired/turbo@8.0.5/dist/turbo.es2017-esm.js

(function (e) {
  typeof e.requestSubmit != "function" &&
    (e.requestSubmit = function (e) {
      if (e) {
        validateSubmitter(e, this);
        e.click();
      } else {
        e = document.createElement("input");
        e.type = "submit";
        e.hidden = true;
        this.appendChild(e);
        e.click();
        this.removeChild(e);
      }
    });
  function validateSubmitter(e, t) {
    e instanceof HTMLElement ||
      raise(TypeError, "parameter 1 is not of type 'HTMLElement'");
    e.type == "submit" ||
      raise(TypeError, "The specified element is not a submit button");
    e.form == t ||
      raise(
        DOMException,
        "The specified element is not owned by this form element",
        "NotFoundError",
      );
  }
  function raise(e, t, r) {
    throw new e(
      "Failed to execute 'requestSubmit' on 'HTMLFormElement': " + t + ".",
      r,
    );
  }
})(HTMLFormElement.prototype);
const e = new WeakMap();
function findSubmitterFromClickTarget(e) {
  const t =
    e instanceof Element ? e : e instanceof Node ? e.parentElement : null;
  const r = t ? t.closest("input, button") : null;
  return r?.type == "submit" ? r : null;
}
function clickCaptured(t) {
  const r = findSubmitterFromClickTarget(t.target);
  r && r.form && e.set(r.form, r);
}
(function () {
  if ("submitter" in Event.prototype) return;
  let t = window.Event.prototype;
  if ("SubmitEvent" in window) {
    const e = window.SubmitEvent.prototype;
    if (!/Apple Computer/.test(navigator.vendor) || "submitter" in e) return;
    t = e;
  }
  addEventListener("click", clickCaptured, true);
  Object.defineProperty(t, "submitter", {
    get() {
      if (this.type == "submit" && this.target instanceof HTMLFormElement)
        return e.get(this.target);
    },
  });
})();
const t = { eager: "eager", lazy: "lazy" };
class FrameElement extends HTMLElement {
  static delegateConstructor = void 0;
  loaded = Promise.resolve();
  static get observedAttributes() {
    return ["disabled", "loading", "src"];
  }
  constructor() {
    super();
    this.delegate = new FrameElement.delegateConstructor(this);
  }
  connectedCallback() {
    this.delegate.connect();
  }
  disconnectedCallback() {
    this.delegate.disconnect();
  }
  reload() {
    return this.delegate.sourceURLReloaded();
  }
  attributeChangedCallback(e) {
    e == "loading"
      ? this.delegate.loadingStyleChanged()
      : e == "src"
        ? this.delegate.sourceURLChanged()
        : e == "disabled" && this.delegate.disabledChanged();
  }
  get src() {
    return this.getAttribute("src");
  }
  set src(e) {
    e ? this.setAttribute("src", e) : this.removeAttribute("src");
  }
  get refresh() {
    return this.getAttribute("refresh");
  }
  set refresh(e) {
    e ? this.setAttribute("refresh", e) : this.removeAttribute("refresh");
  }
  get loading() {
    return frameLoadingStyleFromString(this.getAttribute("loading") || "");
  }
  set loading(e) {
    e ? this.setAttribute("loading", e) : this.removeAttribute("loading");
  }
  get disabled() {
    return this.hasAttribute("disabled");
  }
  set disabled(e) {
    e ? this.setAttribute("disabled", "") : this.removeAttribute("disabled");
  }
  get autoscroll() {
    return this.hasAttribute("autoscroll");
  }
  set autoscroll(e) {
    e
      ? this.setAttribute("autoscroll", "")
      : this.removeAttribute("autoscroll");
  }
  get complete() {
    return !this.delegate.isLoading;
  }
  get isActive() {
    return this.ownerDocument === document && !this.isPreview;
  }
  get isPreview() {
    return this.ownerDocument?.documentElement?.hasAttribute(
      "data-turbo-preview",
    );
  }
}
function frameLoadingStyleFromString(e) {
  switch (e.toLowerCase()) {
    case "lazy":
      return t.lazy;
    default:
      return t.eager;
  }
}
function expandURL(e) {
  return new URL(e.toString(), document.baseURI);
}
function getAnchor(e) {
  let t;
  return e.hash
    ? e.hash.slice(1)
    : (t = e.href.match(/#(.*)$/))
      ? t[1]
      : void 0;
}
function getAction$1(e, t) {
  const r =
    t?.getAttribute("formaction") || e.getAttribute("action") || e.action;
  return expandURL(r);
}
function getExtension(e) {
  return (getLastPathComponent(e).match(/\.[^.]*$/) || [])[0] || "";
}
function isHTML(e) {
  return !!getExtension(e).match(/^(?:|\.(?:htm|html|xhtml|php))$/);
}
function isPrefixedBy(e, t) {
  const r = getPrefix(t);
  return e.href === expandURL(r).href || e.href.startsWith(r);
}
function locationIsVisitable(e, t) {
  return isPrefixedBy(e, t) && isHTML(e);
}
function getRequestURL(e) {
  const t = getAnchor(e);
  return t != null ? e.href.slice(0, -(t.length + 1)) : e.href;
}
function toCacheKey(e) {
  return getRequestURL(e);
}
function urlsAreEqual(e, t) {
  return expandURL(e).href == expandURL(t).href;
}
function getPathComponents(e) {
  return e.pathname.split("/").slice(1);
}
function getLastPathComponent(e) {
  return getPathComponents(e).slice(-1)[0];
}
function getPrefix(e) {
  return addTrailingSlash(e.origin + e.pathname);
}
function addTrailingSlash(e) {
  return e.endsWith("/") ? e : e + "/";
}
class FetchResponse {
  constructor(e) {
    this.response = e;
  }
  get succeeded() {
    return this.response.ok;
  }
  get failed() {
    return !this.succeeded;
  }
  get clientError() {
    return this.statusCode >= 400 && this.statusCode <= 499;
  }
  get serverError() {
    return this.statusCode >= 500 && this.statusCode <= 599;
  }
  get redirected() {
    return this.response.redirected;
  }
  get location() {
    return expandURL(this.response.url);
  }
  get isHTML() {
    return (
      this.contentType &&
      this.contentType.match(
        /^(?:text\/([^\s;,]+\b)?html|application\/xhtml\+xml)\b/,
      )
    );
  }
  get statusCode() {
    return this.response.status;
  }
  get contentType() {
    return this.header("Content-Type");
  }
  get responseText() {
    return this.response.clone().text();
  }
  get responseHTML() {
    return this.isHTML ? this.response.clone().text() : Promise.resolve(void 0);
  }
  header(e) {
    return this.response.headers.get(e);
  }
}
function activateScriptElement(e) {
  if (e.getAttribute("data-turbo-eval") == "false") return e;
  {
    const t = document.createElement("script");
    const r = getMetaContent("csp-nonce");
    r && (t.nonce = r);
    t.textContent = e.textContent;
    t.async = false;
    copyElementAttributes(t, e);
    return t;
  }
}
function copyElementAttributes(e, t) {
  for (const { name: r, value: s } of t.attributes) e.setAttribute(r, s);
}
function createDocumentFragment(e) {
  const t = document.createElement("template");
  t.innerHTML = e;
  return t.content;
}
function dispatch(e, { target: t, cancelable: r, detail: s } = {}) {
  const i = new CustomEvent(e, {
    cancelable: r,
    bubbles: true,
    composed: true,
    detail: s,
  });
  t && t.isConnected
    ? t.dispatchEvent(i)
    : document.documentElement.dispatchEvent(i);
  return i;
}
function nextRepaint() {
  return document.visibilityState === "hidden"
    ? nextEventLoopTick()
    : nextAnimationFrame();
}
function nextAnimationFrame() {
  return new Promise((e) => requestAnimationFrame(() => e()));
}
function nextEventLoopTick() {
  return new Promise((e) => setTimeout(() => e(), 0));
}
function nextMicrotask() {
  return Promise.resolve();
}
function parseHTMLDocument(e = "") {
  return new DOMParser().parseFromString(e, "text/html");
}
function unindent(e, ...t) {
  const r = interpolate(e, t).replace(/^\n/, "").split("\n");
  const s = r[0].match(/^\s+/);
  const i = s ? s[0].length : 0;
  return r.map((e) => e.slice(i)).join("\n");
}
function interpolate(e, t) {
  return e.reduce((e, r, s) => {
    const i = t[s] == void 0 ? "" : t[s];
    return e + r + i;
  }, "");
}
function uuid() {
  return Array.from({ length: 36 })
    .map((e, t) =>
      t == 8 || t == 13 || t == 18 || t == 23
        ? "-"
        : t == 14
          ? "4"
          : t == 19
            ? (Math.floor(Math.random() * 4) + 8).toString(16)
            : Math.floor(Math.random() * 15).toString(16),
    )
    .join("");
}
function getAttribute(e, ...t) {
  for (const r of t.map((t) => t?.getAttribute(e)))
    if (typeof r == "string") return r;
  return null;
}
function hasAttribute(e, ...t) {
  return t.some((t) => t && t.hasAttribute(e));
}
function markAsBusy(...e) {
  for (const t of e) {
    t.localName == "turbo-frame" && t.setAttribute("busy", "");
    t.setAttribute("aria-busy", "true");
  }
}
function clearBusyState(...e) {
  for (const t of e) {
    t.localName == "turbo-frame" && t.removeAttribute("busy");
    t.removeAttribute("aria-busy");
  }
}
function waitForLoad(e, t = 2e3) {
  return new Promise((r) => {
    const onComplete = () => {
      e.removeEventListener("error", onComplete);
      e.removeEventListener("load", onComplete);
      r();
    };
    e.addEventListener("load", onComplete, { once: true });
    e.addEventListener("error", onComplete, { once: true });
    setTimeout(r, t);
  });
}
function getHistoryMethodForAction(e) {
  switch (e) {
    case "replace":
      return history.replaceState;
    case "advance":
    case "restore":
      return history.pushState;
  }
}
function isAction(e) {
  return e == "advance" || e == "replace" || e == "restore";
}
function getVisitAction(...e) {
  const t = getAttribute("data-turbo-action", ...e);
  return isAction(t) ? t : null;
}
function getMetaElement(e) {
  return document.querySelector(`meta[name="${e}"]`);
}
function getMetaContent(e) {
  const t = getMetaElement(e);
  return t && t.content;
}
function setMetaContent(e, t) {
  let r = getMetaElement(e);
  if (!r) {
    r = document.createElement("meta");
    r.setAttribute("name", e);
    document.head.appendChild(r);
  }
  r.setAttribute("content", t);
  return r;
}
function findClosestRecursively(e, t) {
  if (e instanceof Element)
    return (
      e.closest(t) ||
      findClosestRecursively(e.assignedSlot || e.getRootNode()?.host, t)
    );
}
function elementIsFocusable(e) {
  const t =
    "[inert], :disabled, [hidden], details:not([open]), dialog:not([open])";
  return !!e && e.closest(t) == null && typeof e.focus == "function";
}
function queryAutofocusableElement(e) {
  return Array.from(e.querySelectorAll("[autofocus]")).find(elementIsFocusable);
}
async function around(e, t) {
  const r = t();
  e();
  await nextAnimationFrame();
  const s = t();
  return [r, s];
}
function doesNotTargetIFrame(e) {
  if (e === "_blank") return false;
  if (e) {
    for (const t of document.getElementsByName(e))
      if (t instanceof HTMLIFrameElement) return false;
    return true;
  }
  return true;
}
function findLinkFromClickTarget(e) {
  return findClosestRecursively(e, "a[href]:not([target^=_]):not([download])");
}
function getLocationForLink(e) {
  return expandURL(e.getAttribute("href") || "");
}
function debounce(e, t) {
  let r = null;
  return (...s) => {
    const callback = () => e.apply(this, s);
    clearTimeout(r);
    r = setTimeout(callback, t);
  };
}
class LimitedSet extends Set {
  constructor(e) {
    super();
    this.maxSize = e;
  }
  add(e) {
    if (this.size >= this.maxSize) {
      const e = this.values();
      const t = e.next().value;
      this.delete(t);
    }
    super.add(e);
  }
}
const r = new LimitedSet(20);
const s = window.fetch;
function fetchWithTurboHeaders(e, t = {}) {
  const i = new Headers(t.headers || {});
  const n = uuid();
  r.add(n);
  i.append("X-Turbo-Request-Id", n);
  return s(e, { ...t, headers: i });
}
function fetchMethodFromString(e) {
  switch (e.toLowerCase()) {
    case "get":
      return i.get;
    case "post":
      return i.post;
    case "put":
      return i.put;
    case "patch":
      return i.patch;
    case "delete":
      return i.delete;
  }
}
const i = {
  get: "get",
  post: "post",
  put: "put",
  patch: "patch",
  delete: "delete",
};
function fetchEnctypeFromString(e) {
  switch (e.toLowerCase()) {
    case n.multipart:
      return n.multipart;
    case n.plain:
      return n.plain;
    default:
      return n.urlEncoded;
  }
}
const n = {
  urlEncoded: "application/x-www-form-urlencoded",
  multipart: "multipart/form-data",
  plain: "text/plain",
};
class FetchRequest {
  abortController = new AbortController();
  #e = (e) => {};
  constructor(e, t, r, s = new URLSearchParams(), i = null, o = n.urlEncoded) {
    const [a, c] = buildResourceAndBody(expandURL(r), t, s, o);
    this.delegate = e;
    this.url = a;
    this.target = i;
    this.fetchOptions = {
      credentials: "same-origin",
      redirect: "follow",
      method: t.toUpperCase(),
      headers: { ...this.defaultHeaders },
      body: c,
      signal: this.abortSignal,
      referrer: this.delegate.referrer?.href,
    };
    this.enctype = o;
  }
  get method() {
    return this.fetchOptions.method;
  }
  set method(e) {
    const t = this.isSafe
      ? this.url.searchParams
      : this.fetchOptions.body || new FormData();
    const r = fetchMethodFromString(e) || i.get;
    this.url.search = "";
    const [s, n] = buildResourceAndBody(this.url, r, t, this.enctype);
    this.url = s;
    this.fetchOptions.body = n;
    this.fetchOptions.method = r.toUpperCase();
  }
  get headers() {
    return this.fetchOptions.headers;
  }
  set headers(e) {
    this.fetchOptions.headers = e;
  }
  get body() {
    return this.isSafe ? this.url.searchParams : this.fetchOptions.body;
  }
  set body(e) {
    this.fetchOptions.body = e;
  }
  get location() {
    return this.url;
  }
  get params() {
    return this.url.searchParams;
  }
  get entries() {
    return this.body ? Array.from(this.body.entries()) : [];
  }
  cancel() {
    this.abortController.abort();
  }
  async perform() {
    const { fetchOptions: e } = this;
    this.delegate.prepareRequest(this);
    const t = await this.#t(e);
    try {
      this.delegate.requestStarted(this);
      t.detail.fetchRequest
        ? (this.response = t.detail.fetchRequest.response)
        : (this.response = fetchWithTurboHeaders(this.url.href, e));
      const r = await this.response;
      return await this.receive(r);
    } catch (e) {
      if (e.name !== "AbortError") {
        this.#r(e) && this.delegate.requestErrored(this, e);
        throw e;
      }
    } finally {
      this.delegate.requestFinished(this);
    }
  }
  async receive(e) {
    const t = new FetchResponse(e);
    const r = dispatch("turbo:before-fetch-response", {
      cancelable: true,
      detail: { fetchResponse: t },
      target: this.target,
    });
    r.defaultPrevented
      ? this.delegate.requestPreventedHandlingResponse(this, t)
      : t.succeeded
        ? this.delegate.requestSucceededWithResponse(this, t)
        : this.delegate.requestFailedWithResponse(this, t);
    return t;
  }
  get defaultHeaders() {
    return { Accept: "text/html, application/xhtml+xml" };
  }
  get isSafe() {
    return isSafe(this.method);
  }
  get abortSignal() {
    return this.abortController.signal;
  }
  acceptResponseType(e) {
    this.headers.Accept = [e, this.headers.Accept].join(", ");
  }
  async #t(e) {
    const t = new Promise((e) => (this.#e = e));
    const r = dispatch("turbo:before-fetch-request", {
      cancelable: true,
      detail: { fetchOptions: e, url: this.url, resume: this.#e },
      target: this.target,
    });
    this.url = r.detail.url;
    r.defaultPrevented && (await t);
    return r;
  }
  #r(e) {
    const t = dispatch("turbo:fetch-request-error", {
      target: this.target,
      cancelable: true,
      detail: { request: this, error: e },
    });
    return !t.defaultPrevented;
  }
}
function isSafe(e) {
  return fetchMethodFromString(e) == i.get;
}
function buildResourceAndBody(e, t, r, s) {
  const i =
    Array.from(r).length > 0
      ? new URLSearchParams(entriesExcludingFiles(r))
      : e.searchParams;
  return isSafe(t)
    ? [mergeIntoURLSearchParams(e, i), null]
    : s == n.urlEncoded
      ? [e, i]
      : [e, r];
}
function entriesExcludingFiles(e) {
  const t = [];
  for (const [r, s] of e) s instanceof File || t.push([r, s]);
  return t;
}
function mergeIntoURLSearchParams(e, t) {
  const r = new URLSearchParams(entriesExcludingFiles(t));
  e.search = r.toString();
  return e;
}
class AppearanceObserver {
  started = false;
  constructor(e, t) {
    this.delegate = e;
    this.element = t;
    this.intersectionObserver = new IntersectionObserver(this.intersect);
  }
  start() {
    if (!this.started) {
      this.started = true;
      this.intersectionObserver.observe(this.element);
    }
  }
  stop() {
    if (this.started) {
      this.started = false;
      this.intersectionObserver.unobserve(this.element);
    }
  }
  intersect = (e) => {
    const t = e.slice(-1)[0];
    t?.isIntersecting && this.delegate.elementAppearedInViewport(this.element);
  };
}
class StreamMessage {
  static contentType = "text/vnd.turbo-stream.html";
  static wrap(e) {
    return typeof e == "string" ? new this(createDocumentFragment(e)) : e;
  }
  constructor(e) {
    this.fragment = importStreamElements(e);
  }
}
function importStreamElements(e) {
  for (const t of e.querySelectorAll("turbo-stream")) {
    const e = document.importNode(t, true);
    for (const t of e.templateElement.content.querySelectorAll("script"))
      t.replaceWith(activateScriptElement(t));
    t.replaceWith(e);
  }
  return e;
}
const o = 100;
class PrefetchCache {
  #s = null;
  #i = null;
  get(e) {
    if (this.#i && this.#i.url === e && this.#i.expire > Date.now())
      return this.#i.request;
  }
  setLater(e, t, r) {
    this.clear();
    this.#s = setTimeout(() => {
      t.perform();
      this.set(e, t, r);
      this.#s = null;
    }, o);
  }
  set(e, t, r) {
    this.#i = {
      url: e,
      request: t,
      expire: new Date(new Date().getTime() + r),
    };
  }
  clear() {
    this.#s && clearTimeout(this.#s);
    this.#i = null;
  }
}
const a = 1e4;
const c = new PrefetchCache();
const l = {
  initialized: "initialized",
  requesting: "requesting",
  waiting: "waiting",
  receiving: "receiving",
  stopping: "stopping",
  stopped: "stopped",
};
class FormSubmission {
  state = l.initialized;
  static confirmMethod(e, t, r) {
    return Promise.resolve(confirm(e));
  }
  constructor(e, t, r, s = false) {
    const i = getMethod(t, r);
    const n = getAction(getFormAction(t, r), i);
    const o = buildFormData(t, r);
    const a = getEnctype(t, r);
    this.delegate = e;
    this.formElement = t;
    this.submitter = r;
    this.fetchRequest = new FetchRequest(this, i, n, o, t, a);
    this.mustRedirect = s;
  }
  get method() {
    return this.fetchRequest.method;
  }
  set method(e) {
    this.fetchRequest.method = e;
  }
  get action() {
    return this.fetchRequest.url.toString();
  }
  set action(e) {
    this.fetchRequest.url = expandURL(e);
  }
  get body() {
    return this.fetchRequest.body;
  }
  get enctype() {
    return this.fetchRequest.enctype;
  }
  get isSafe() {
    return this.fetchRequest.isSafe;
  }
  get location() {
    return this.fetchRequest.url;
  }
  async start() {
    const { initialized: e, requesting: t } = l;
    const r = getAttribute(
      "data-turbo-confirm",
      this.submitter,
      this.formElement,
    );
    if (typeof r === "string") {
      const e = await FormSubmission.confirmMethod(
        r,
        this.formElement,
        this.submitter,
      );
      if (!e) return;
    }
    if (this.state == e) {
      this.state = t;
      return this.fetchRequest.perform();
    }
  }
  stop() {
    const { stopping: e, stopped: t } = l;
    if (this.state != e && this.state != t) {
      this.state = e;
      this.fetchRequest.cancel();
      return true;
    }
  }
  prepareRequest(e) {
    if (!e.isSafe) {
      const t =
        getCookieValue(getMetaContent("csrf-param")) ||
        getMetaContent("csrf-token");
      t && (e.headers["X-CSRF-Token"] = t);
    }
    this.requestAcceptsTurboStreamResponse(e) &&
      e.acceptResponseType(StreamMessage.contentType);
  }
  requestStarted(e) {
    this.state = l.waiting;
    this.submitter?.setAttribute("disabled", "");
    this.setSubmitsWith();
    markAsBusy(this.formElement);
    dispatch("turbo:submit-start", {
      target: this.formElement,
      detail: { formSubmission: this },
    });
    this.delegate.formSubmissionStarted(this);
  }
  requestPreventedHandlingResponse(e, t) {
    c.clear();
    this.result = { success: t.succeeded, fetchResponse: t };
  }
  requestSucceededWithResponse(e, t) {
    if (t.clientError || t.serverError)
      this.delegate.formSubmissionFailedWithResponse(this, t);
    else {
      c.clear();
      if (this.requestMustRedirect(e) && responseSucceededWithoutRedirect(t)) {
        const e = new Error("Form responses must redirect to another location");
        this.delegate.formSubmissionErrored(this, e);
      } else {
        this.state = l.receiving;
        this.result = { success: true, fetchResponse: t };
        this.delegate.formSubmissionSucceededWithResponse(this, t);
      }
    }
  }
  requestFailedWithResponse(e, t) {
    this.result = { success: false, fetchResponse: t };
    this.delegate.formSubmissionFailedWithResponse(this, t);
  }
  requestErrored(e, t) {
    this.result = { success: false, error: t };
    this.delegate.formSubmissionErrored(this, t);
  }
  requestFinished(e) {
    this.state = l.stopped;
    this.submitter?.removeAttribute("disabled");
    this.resetSubmitterText();
    clearBusyState(this.formElement);
    dispatch("turbo:submit-end", {
      target: this.formElement,
      detail: { formSubmission: this, ...this.result },
    });
    this.delegate.formSubmissionFinished(this);
  }
  setSubmitsWith() {
    if (this.submitter && this.submitsWith)
      if (this.submitter.matches("button")) {
        this.originalSubmitText = this.submitter.innerHTML;
        this.submitter.innerHTML = this.submitsWith;
      } else if (this.submitter.matches("input")) {
        const e = this.submitter;
        this.originalSubmitText = e.value;
        e.value = this.submitsWith;
      }
  }
  resetSubmitterText() {
    if (this.submitter && this.originalSubmitText)
      if (this.submitter.matches("button"))
        this.submitter.innerHTML = this.originalSubmitText;
      else if (this.submitter.matches("input")) {
        const e = this.submitter;
        e.value = this.originalSubmitText;
      }
  }
  requestMustRedirect(e) {
    return !e.isSafe && this.mustRedirect;
  }
  requestAcceptsTurboStreamResponse(e) {
    return (
      !e.isSafe ||
      hasAttribute("data-turbo-stream", this.submitter, this.formElement)
    );
  }
  get submitsWith() {
    return this.submitter?.getAttribute("data-turbo-submits-with");
  }
}
function buildFormData(e, t) {
  const r = new FormData(e);
  const s = t?.getAttribute("name");
  const i = t?.getAttribute("value");
  s && r.append(s, i || "");
  return r;
}
function getCookieValue(e) {
  if (e != null) {
    const t = document.cookie ? document.cookie.split("; ") : [];
    const r = t.find((t) => t.startsWith(e));
    if (r) {
      const e = r.split("=").slice(1).join("=");
      return e ? decodeURIComponent(e) : void 0;
    }
  }
}
function responseSucceededWithoutRedirect(e) {
  return e.statusCode == 200 && !e.redirected;
}
function getFormAction(e, t) {
  const r = typeof e.action === "string" ? e.action : null;
  return t?.hasAttribute("formaction")
    ? t.getAttribute("formaction") || ""
    : e.getAttribute("action") || r || "";
}
function getAction(e, t) {
  const r = expandURL(e);
  isSafe(t) && (r.search = "");
  return r;
}
function getMethod(e, t) {
  const r = t?.getAttribute("formmethod") || e.getAttribute("method") || "";
  return fetchMethodFromString(r.toLowerCase()) || i.get;
}
function getEnctype(e, t) {
  return fetchEnctypeFromString(t?.getAttribute("formenctype") || e.enctype);
}
class Snapshot {
  constructor(e) {
    this.element = e;
  }
  get activeElement() {
    return this.element.ownerDocument.activeElement;
  }
  get children() {
    return [...this.element.children];
  }
  hasAnchor(e) {
    return this.getElementForAnchor(e) != null;
  }
  getElementForAnchor(e) {
    return e ? this.element.querySelector(`[id='${e}'], a[name='${e}']`) : null;
  }
  get isConnected() {
    return this.element.isConnected;
  }
  get firstAutofocusableElement() {
    return queryAutofocusableElement(this.element);
  }
  get permanentElements() {
    return queryPermanentElementsAll(this.element);
  }
  getPermanentElementById(e) {
    return getPermanentElementById(this.element, e);
  }
  getPermanentElementMapForSnapshot(e) {
    const t = {};
    for (const r of this.permanentElements) {
      const { id: s } = r;
      const i = e.getPermanentElementById(s);
      i && (t[s] = [r, i]);
    }
    return t;
  }
}
function getPermanentElementById(e, t) {
  return e.querySelector(`#${t}[data-turbo-permanent]`);
}
function queryPermanentElementsAll(e) {
  return e.querySelectorAll("[id][data-turbo-permanent]");
}
class FormSubmitObserver {
  started = false;
  constructor(e, t) {
    this.delegate = e;
    this.eventTarget = t;
  }
  start() {
    if (!this.started) {
      this.eventTarget.addEventListener("submit", this.submitCaptured, true);
      this.started = true;
    }
  }
  stop() {
    if (this.started) {
      this.eventTarget.removeEventListener("submit", this.submitCaptured, true);
      this.started = false;
    }
  }
  submitCaptured = () => {
    this.eventTarget.removeEventListener("submit", this.submitBubbled, false);
    this.eventTarget.addEventListener("submit", this.submitBubbled, false);
  };
  submitBubbled = (e) => {
    if (!e.defaultPrevented) {
      const t = e.target instanceof HTMLFormElement ? e.target : void 0;
      const r = e.submitter || void 0;
      if (
        t &&
        submissionDoesNotDismissDialog(t, r) &&
        submissionDoesNotTargetIFrame(t, r) &&
        this.delegate.willSubmitForm(t, r)
      ) {
        e.preventDefault();
        e.stopImmediatePropagation();
        this.delegate.formSubmitted(t, r);
      }
    }
  };
}
function submissionDoesNotDismissDialog(e, t) {
  const r = t?.getAttribute("formmethod") || e.getAttribute("method");
  return r != "dialog";
}
function submissionDoesNotTargetIFrame(e, t) {
  const r = t?.getAttribute("formtarget") || e.getAttribute("target");
  return doesNotTargetIFrame(r);
}
class View {
  #n = (e) => {};
  #o = (e) => {};
  constructor(e, t) {
    this.delegate = e;
    this.element = t;
  }
  scrollToAnchor(e) {
    const t = this.snapshot.getElementForAnchor(e);
    if (t) {
      this.scrollToElement(t);
      this.focusElement(t);
    } else this.scrollToPosition({ x: 0, y: 0 });
  }
  scrollToAnchorFromLocation(e) {
    this.scrollToAnchor(getAnchor(e));
  }
  scrollToElement(e) {
    e.scrollIntoView();
  }
  focusElement(e) {
    if (e instanceof HTMLElement)
      if (e.hasAttribute("tabindex")) e.focus();
      else {
        e.setAttribute("tabindex", "-1");
        e.focus();
        e.removeAttribute("tabindex");
      }
  }
  scrollToPosition({ x: e, y: t }) {
    this.scrollRoot.scrollTo(e, t);
  }
  scrollToTop() {
    this.scrollToPosition({ x: 0, y: 0 });
  }
  get scrollRoot() {
    return window;
  }
  async render(e) {
    const { isPreview: t, shouldRender: r, willRender: s, newSnapshot: i } = e;
    const n = s;
    if (r)
      try {
        this.renderPromise = new Promise((e) => (this.#n = e));
        this.renderer = e;
        await this.prepareToRenderSnapshot(e);
        const r = new Promise((e) => (this.#o = e));
        const s = {
          resume: this.#o,
          render: this.renderer.renderElement,
          renderMethod: this.renderer.renderMethod,
        };
        const n = this.delegate.allowsImmediateRender(i, s);
        n || (await r);
        await this.renderSnapshot(e);
        this.delegate.viewRenderedSnapshot(i, t, this.renderer.renderMethod);
        this.delegate.preloadOnLoadLinksForView(this.element);
        this.finishRenderingSnapshot(e);
      } finally {
        delete this.renderer;
        this.#n(void 0);
        delete this.renderPromise;
      }
    else n && this.invalidate(e.reloadReason);
  }
  invalidate(e) {
    this.delegate.viewInvalidated(e);
  }
  async prepareToRenderSnapshot(e) {
    this.markAsPreview(e.isPreview);
    await e.prepareToRender();
  }
  markAsPreview(e) {
    e
      ? this.element.setAttribute("data-turbo-preview", "")
      : this.element.removeAttribute("data-turbo-preview");
  }
  markVisitDirection(e) {
    this.element.setAttribute("data-turbo-visit-direction", e);
  }
  unmarkVisitDirection() {
    this.element.removeAttribute("data-turbo-visit-direction");
  }
  async renderSnapshot(e) {
    await e.render();
  }
  finishRenderingSnapshot(e) {
    e.finishRendering();
  }
}
class FrameView extends View {
  missing() {
    this.element.innerHTML =
      '<strong class="turbo-frame-error">Content missing</strong>';
  }
  get snapshot() {
    return new Snapshot(this.element);
  }
}
class LinkInterceptor {
  constructor(e, t) {
    this.delegate = e;
    this.element = t;
  }
  start() {
    this.element.addEventListener("click", this.clickBubbled);
    document.addEventListener("turbo:click", this.linkClicked);
    document.addEventListener("turbo:before-visit", this.willVisit);
  }
  stop() {
    this.element.removeEventListener("click", this.clickBubbled);
    document.removeEventListener("turbo:click", this.linkClicked);
    document.removeEventListener("turbo:before-visit", this.willVisit);
  }
  clickBubbled = (e) => {
    this.clickEventIsSignificant(e)
      ? (this.clickEvent = e)
      : delete this.clickEvent;
  };
  linkClicked = (e) => {
    if (
      this.clickEvent &&
      this.clickEventIsSignificant(e) &&
      this.delegate.shouldInterceptLinkClick(
        e.target,
        e.detail.url,
        e.detail.originalEvent,
      )
    ) {
      this.clickEvent.preventDefault();
      e.preventDefault();
      this.delegate.linkClickIntercepted(
        e.target,
        e.detail.url,
        e.detail.originalEvent,
      );
    }
    delete this.clickEvent;
  };
  willVisit = (e) => {
    delete this.clickEvent;
  };
  clickEventIsSignificant(e) {
    const t = e.composed ? e.target?.parentElement : e.target;
    const r = findLinkFromClickTarget(t) || t;
    return (
      r instanceof Element && r.closest("turbo-frame, html") == this.element
    );
  }
}
class LinkClickObserver {
  started = false;
  constructor(e, t) {
    this.delegate = e;
    this.eventTarget = t;
  }
  start() {
    if (!this.started) {
      this.eventTarget.addEventListener("click", this.clickCaptured, true);
      this.started = true;
    }
  }
  stop() {
    if (this.started) {
      this.eventTarget.removeEventListener("click", this.clickCaptured, true);
      this.started = false;
    }
  }
  clickCaptured = () => {
    this.eventTarget.removeEventListener("click", this.clickBubbled, false);
    this.eventTarget.addEventListener("click", this.clickBubbled, false);
  };
  clickBubbled = (e) => {
    if (e instanceof MouseEvent && this.clickEventIsSignificant(e)) {
      const t = (e.composedPath && e.composedPath()[0]) || e.target;
      const r = findLinkFromClickTarget(t);
      if (r && doesNotTargetIFrame(r.target)) {
        const t = getLocationForLink(r);
        if (this.delegate.willFollowLinkToLocation(r, t, e)) {
          e.preventDefault();
          this.delegate.followedLinkToLocation(r, t);
        }
      }
    }
  };
  clickEventIsSignificant(e) {
    return !(
      (e.target && e.target.isContentEditable) ||
      e.defaultPrevented ||
      e.which > 1 ||
      e.altKey ||
      e.ctrlKey ||
      e.metaKey ||
      e.shiftKey
    );
  }
}
class FormLinkClickObserver {
  constructor(e, t) {
    this.delegate = e;
    this.linkInterceptor = new LinkClickObserver(this, t);
  }
  start() {
    this.linkInterceptor.start();
  }
  stop() {
    this.linkInterceptor.stop();
  }
  canPrefetchRequestToLocation(e, t) {
    return false;
  }
  prefetchAndCacheRequestToLocation(e, t) {}
  willFollowLinkToLocation(e, t, r) {
    return (
      this.delegate.willSubmitFormLinkToLocation(e, t, r) &&
      (e.hasAttribute("data-turbo-method") ||
        e.hasAttribute("data-turbo-stream"))
    );
  }
  followedLinkToLocation(e, t) {
    const r = document.createElement("form");
    const s = "hidden";
    for (const [e, i] of t.searchParams)
      r.append(
        Object.assign(document.createElement("input"), {
          type: s,
          name: e,
          value: i,
        }),
      );
    const i = Object.assign(t, { search: "" });
    r.setAttribute("data-turbo", "true");
    r.setAttribute("action", i.href);
    r.setAttribute("hidden", "");
    const n = e.getAttribute("data-turbo-method");
    n && r.setAttribute("method", n);
    const o = e.getAttribute("data-turbo-frame");
    o && r.setAttribute("data-turbo-frame", o);
    const a = getVisitAction(e);
    a && r.setAttribute("data-turbo-action", a);
    const c = e.getAttribute("data-turbo-confirm");
    c && r.setAttribute("data-turbo-confirm", c);
    const l = e.hasAttribute("data-turbo-stream");
    l && r.setAttribute("data-turbo-stream", "");
    this.delegate.submittedFormLinkToLocation(e, t, r);
    document.body.appendChild(r);
    r.addEventListener("turbo:submit-end", () => r.remove(), { once: true });
    requestAnimationFrame(() => r.requestSubmit());
  }
}
class Bardo {
  static async preservingPermanentElements(e, t, r) {
    const s = new this(e, t);
    s.enter();
    await r();
    s.leave();
  }
  constructor(e, t) {
    this.delegate = e;
    this.permanentElementMap = t;
  }
  enter() {
    for (const e in this.permanentElementMap) {
      const [t, r] = this.permanentElementMap[e];
      this.delegate.enteringBardo(t, r);
      this.replaceNewPermanentElementWithPlaceholder(r);
    }
  }
  leave() {
    for (const e in this.permanentElementMap) {
      const [t] = this.permanentElementMap[e];
      this.replaceCurrentPermanentElementWithClone(t);
      this.replacePlaceholderWithPermanentElement(t);
      this.delegate.leavingBardo(t);
    }
  }
  replaceNewPermanentElementWithPlaceholder(e) {
    const t = createPlaceholderForPermanentElement(e);
    e.replaceWith(t);
  }
  replaceCurrentPermanentElementWithClone(e) {
    const t = e.cloneNode(true);
    e.replaceWith(t);
  }
  replacePlaceholderWithPermanentElement(e) {
    const t = this.getPlaceholderById(e.id);
    t?.replaceWith(e);
  }
  getPlaceholderById(e) {
    return this.placeholders.find((t) => t.content == e);
  }
  get placeholders() {
    return [
      ...document.querySelectorAll(
        "meta[name=turbo-permanent-placeholder][content]",
      ),
    ];
  }
}
function createPlaceholderForPermanentElement(e) {
  const t = document.createElement("meta");
  t.setAttribute("name", "turbo-permanent-placeholder");
  t.setAttribute("content", e.id);
  return t;
}
class Renderer {
  #a = null;
  constructor(e, t, r, s, i = true) {
    this.currentSnapshot = e;
    this.newSnapshot = t;
    this.isPreview = s;
    this.willRender = i;
    this.renderElement = r;
    this.promise = new Promise(
      (e, t) => (this.resolvingFunctions = { resolve: e, reject: t }),
    );
  }
  get shouldRender() {
    return true;
  }
  get shouldAutofocus() {
    return true;
  }
  get reloadReason() {}
  prepareToRender() {}
  render() {}
  finishRendering() {
    if (this.resolvingFunctions) {
      this.resolvingFunctions.resolve();
      delete this.resolvingFunctions;
    }
  }
  async preservingPermanentElements(e) {
    await Bardo.preservingPermanentElements(this, this.permanentElementMap, e);
  }
  focusFirstAutofocusableElement() {
    if (this.shouldAutofocus) {
      const e = this.connectedSnapshot.firstAutofocusableElement;
      e && e.focus();
    }
  }
  enteringBardo(e) {
    this.#a ||
      (e.contains(this.currentSnapshot.activeElement) &&
        (this.#a = this.currentSnapshot.activeElement));
  }
  leavingBardo(e) {
    if (e.contains(this.#a) && this.#a instanceof HTMLElement) {
      this.#a.focus();
      this.#a = null;
    }
  }
  get connectedSnapshot() {
    return this.newSnapshot.isConnected
      ? this.newSnapshot
      : this.currentSnapshot;
  }
  get currentElement() {
    return this.currentSnapshot.element;
  }
  get newElement() {
    return this.newSnapshot.element;
  }
  get permanentElementMap() {
    return this.currentSnapshot.getPermanentElementMapForSnapshot(
      this.newSnapshot,
    );
  }
  get renderMethod() {
    return "replace";
  }
}
class FrameRenderer extends Renderer {
  static renderElement(e, t) {
    const r = document.createRange();
    r.selectNodeContents(e);
    r.deleteContents();
    const s = t;
    const i = s.ownerDocument?.createRange();
    if (i) {
      i.selectNodeContents(s);
      e.appendChild(i.extractContents());
    }
  }
  constructor(e, t, r, s, i, n = true) {
    super(t, r, s, i, n);
    this.delegate = e;
  }
  get shouldRender() {
    return true;
  }
  async render() {
    await nextRepaint();
    this.preservingPermanentElements(() => {
      this.loadFrameElement();
    });
    this.scrollFrameIntoView();
    await nextRepaint();
    this.focusFirstAutofocusableElement();
    await nextRepaint();
    this.activateScriptElements();
  }
  loadFrameElement() {
    this.delegate.willRenderFrame(this.currentElement, this.newElement);
    this.renderElement(this.currentElement, this.newElement);
  }
  scrollFrameIntoView() {
    if (this.currentElement.autoscroll || this.newElement.autoscroll) {
      const e = this.currentElement.firstElementChild;
      const t = readScrollLogicalPosition(
        this.currentElement.getAttribute("data-autoscroll-block"),
        "end",
      );
      const r = readScrollBehavior(
        this.currentElement.getAttribute("data-autoscroll-behavior"),
        "auto",
      );
      if (e) {
        e.scrollIntoView({ block: t, behavior: r });
        return true;
      }
    }
    return false;
  }
  activateScriptElements() {
    for (const e of this.newScriptElements) {
      const t = activateScriptElement(e);
      e.replaceWith(t);
    }
  }
  get newScriptElements() {
    return this.currentElement.querySelectorAll("script");
  }
}
function readScrollLogicalPosition(e, t) {
  return e == "end" || e == "start" || e == "center" || e == "nearest" ? e : t;
}
function readScrollBehavior(e, t) {
  return e == "auto" || e == "smooth" ? e : t;
}
class ProgressBar {
  static animationDuration = 300;
  static get defaultCSS() {
    return unindent`
      .turbo-progress-bar {
        position: fixed;
        display: block;
        top: 0;
        left: 0;
        height: 3px;
        background: #0076ff;
        z-index: 2147483647;
        transition:
          width ${ProgressBar.animationDuration}ms ease-out,
          opacity ${ProgressBar.animationDuration / 2}ms ${ProgressBar.animationDuration / 2}ms ease-in;
        transform: translate3d(0, 0, 0);
      }
    `;
  }
  hiding = false;
  value = 0;
  visible = false;
  constructor() {
    this.stylesheetElement = this.createStylesheetElement();
    this.progressElement = this.createProgressElement();
    this.installStylesheetElement();
    this.setValue(0);
  }
  show() {
    if (!this.visible) {
      this.visible = true;
      this.installProgressElement();
      this.startTrickling();
    }
  }
  hide() {
    if (this.visible && !this.hiding) {
      this.hiding = true;
      this.fadeProgressElement(() => {
        this.uninstallProgressElement();
        this.stopTrickling();
        this.visible = false;
        this.hiding = false;
      });
    }
  }
  setValue(e) {
    this.value = e;
    this.refresh();
  }
  installStylesheetElement() {
    document.head.insertBefore(
      this.stylesheetElement,
      document.head.firstChild,
    );
  }
  installProgressElement() {
    this.progressElement.style.width = "0";
    this.progressElement.style.opacity = "1";
    document.documentElement.insertBefore(this.progressElement, document.body);
    this.refresh();
  }
  fadeProgressElement(e) {
    this.progressElement.style.opacity = "0";
    setTimeout(e, ProgressBar.animationDuration * 1.5);
  }
  uninstallProgressElement() {
    this.progressElement.parentNode &&
      document.documentElement.removeChild(this.progressElement);
  }
  startTrickling() {
    this.trickleInterval ||
      (this.trickleInterval = window.setInterval(
        this.trickle,
        ProgressBar.animationDuration,
      ));
  }
  stopTrickling() {
    window.clearInterval(this.trickleInterval);
    delete this.trickleInterval;
  }
  trickle = () => {
    this.setValue(this.value + Math.random() / 100);
  };
  refresh() {
    requestAnimationFrame(() => {
      this.progressElement.style.width = 10 + this.value * 90 + "%";
    });
  }
  createStylesheetElement() {
    const e = document.createElement("style");
    e.type = "text/css";
    e.textContent = ProgressBar.defaultCSS;
    this.cspNonce && (e.nonce = this.cspNonce);
    return e;
  }
  createProgressElement() {
    const e = document.createElement("div");
    e.className = "turbo-progress-bar";
    return e;
  }
  get cspNonce() {
    return getMetaContent("csp-nonce");
  }
}
class HeadSnapshot extends Snapshot {
  detailsByOuterHTML = this.children
    .filter((e) => !elementIsNoscript(e))
    .map((e) => elementWithoutNonce(e))
    .reduce((e, t) => {
      const { outerHTML: r } = t;
      const s =
        r in e
          ? e[r]
          : {
              type: elementType(t),
              tracked: elementIsTracked(t),
              elements: [],
            };
      return { ...e, [r]: { ...s, elements: [...s.elements, t] } };
    }, {});
  get trackedElementSignature() {
    return Object.keys(this.detailsByOuterHTML)
      .filter((e) => this.detailsByOuterHTML[e].tracked)
      .join("");
  }
  getScriptElementsNotInSnapshot(e) {
    return this.getElementsMatchingTypeNotInSnapshot("script", e);
  }
  getStylesheetElementsNotInSnapshot(e) {
    return this.getElementsMatchingTypeNotInSnapshot("stylesheet", e);
  }
  getElementsMatchingTypeNotInSnapshot(e, t) {
    return Object.keys(this.detailsByOuterHTML)
      .filter((e) => !(e in t.detailsByOuterHTML))
      .map((e) => this.detailsByOuterHTML[e])
      .filter(({ type: t }) => t == e)
      .map(({ elements: [e] }) => e);
  }
  get provisionalElements() {
    return Object.keys(this.detailsByOuterHTML).reduce((e, t) => {
      const { type: r, tracked: s, elements: i } = this.detailsByOuterHTML[t];
      return r != null || s
        ? i.length > 1
          ? [...e, ...i.slice(1)]
          : e
        : [...e, ...i];
    }, []);
  }
  getMetaValue(e) {
    const t = this.findMetaElementByName(e);
    return t ? t.getAttribute("content") : null;
  }
  findMetaElementByName(e) {
    return Object.keys(this.detailsByOuterHTML).reduce((t, r) => {
      const {
        elements: [s],
      } = this.detailsByOuterHTML[r];
      return elementIsMetaElementWithName(s, e) ? s : t;
    }, 0);
  }
}
function elementType(e) {
  return elementIsScript(e)
    ? "script"
    : elementIsStylesheet(e)
      ? "stylesheet"
      : void 0;
}
function elementIsTracked(e) {
  return e.getAttribute("data-turbo-track") == "reload";
}
function elementIsScript(e) {
  const t = e.localName;
  return t == "script";
}
function elementIsNoscript(e) {
  const t = e.localName;
  return t == "noscript";
}
function elementIsStylesheet(e) {
  const t = e.localName;
  return t == "style" || (t == "link" && e.getAttribute("rel") == "stylesheet");
}
function elementIsMetaElementWithName(e, t) {
  const r = e.localName;
  return r == "meta" && e.getAttribute("name") == t;
}
function elementWithoutNonce(e) {
  e.hasAttribute("nonce") && e.setAttribute("nonce", "");
  return e;
}
class PageSnapshot extends Snapshot {
  static fromHTMLString(e = "") {
    return this.fromDocument(parseHTMLDocument(e));
  }
  static fromElement(e) {
    return this.fromDocument(e.ownerDocument);
  }
  static fromDocument({ documentElement: e, body: t, head: r }) {
    return new this(e, t, new HeadSnapshot(r));
  }
  constructor(e, t, r) {
    super(t);
    this.documentElement = e;
    this.headSnapshot = r;
  }
  clone() {
    const e = this.element.cloneNode(true);
    const t = this.element.querySelectorAll("select");
    const r = e.querySelectorAll("select");
    for (const [e, s] of t.entries()) {
      const t = r[e];
      for (const e of t.selectedOptions) e.selected = false;
      for (const e of s.selectedOptions) t.options[e.index].selected = true;
    }
    for (const t of e.querySelectorAll('input[type="password"]')) t.value = "";
    return new PageSnapshot(this.documentElement, e, this.headSnapshot);
  }
  get lang() {
    return this.documentElement.getAttribute("lang");
  }
  get headElement() {
    return this.headSnapshot.element;
  }
  get rootLocation() {
    const e = this.getSetting("root") ?? "/";
    return expandURL(e);
  }
  get cacheControlValue() {
    return this.getSetting("cache-control");
  }
  get isPreviewable() {
    return this.cacheControlValue != "no-preview";
  }
  get isCacheable() {
    return this.cacheControlValue != "no-cache";
  }
  get isVisitable() {
    return this.getSetting("visit-control") != "reload";
  }
  get prefersViewTransitions() {
    return this.headSnapshot.getMetaValue("view-transition") === "same-origin";
  }
  get shouldMorphPage() {
    return this.getSetting("refresh-method") === "morph";
  }
  get shouldPreserveScrollPosition() {
    return this.getSetting("refresh-scroll") === "preserve";
  }
  getSetting(e) {
    return this.headSnapshot.getMetaValue(`turbo-${e}`);
  }
}
class ViewTransitioner {
  #c = false;
  #l = Promise.resolve();
  renderChange(e, t) {
    if (e && this.viewTransitionsAvailable && !this.#c) {
      this.#c = true;
      this.#l = this.#l.then(async () => {
        await document.startViewTransition(t).finished;
      });
    } else this.#l = this.#l.then(t);
    return this.#l;
  }
  get viewTransitionsAvailable() {
    return document.startViewTransition;
  }
}
const h = {
  action: "advance",
  historyChanged: false,
  visitCachedSnapshot: () => {},
  willRender: true,
  updateHistory: true,
  shouldCacheSnapshot: true,
  acceptsStreamResponse: false,
};
const d = {
  visitStart: "visitStart",
  requestStart: "requestStart",
  requestEnd: "requestEnd",
  visitEnd: "visitEnd",
};
const u = {
  initialized: "initialized",
  started: "started",
  canceled: "canceled",
  failed: "failed",
  completed: "completed",
};
const m = { networkFailure: 0, timeoutFailure: -1, contentTypeMismatch: -2 };
const p = { advance: "forward", restore: "back", replace: "none" };
class Visit {
  identifier = uuid();
  timingMetrics = {};
  followedRedirect = false;
  historyChanged = false;
  scrolled = false;
  shouldCacheSnapshot = true;
  acceptsStreamResponse = false;
  snapshotCached = false;
  state = u.initialized;
  viewTransitioner = new ViewTransitioner();
  constructor(e, t, r, s = {}) {
    this.delegate = e;
    this.location = t;
    this.restorationIdentifier = r || uuid();
    const {
      action: i,
      historyChanged: n,
      referrer: o,
      snapshot: a,
      snapshotHTML: c,
      response: l,
      visitCachedSnapshot: d,
      willRender: u,
      updateHistory: m,
      shouldCacheSnapshot: f,
      acceptsStreamResponse: g,
      direction: b,
    } = { ...h, ...s };
    this.action = i;
    this.historyChanged = n;
    this.referrer = o;
    this.snapshot = a;
    this.snapshotHTML = c;
    this.response = l;
    this.isSamePage = this.delegate.locationWithActionIsSamePage(
      this.location,
      this.action,
    );
    this.isPageRefresh = this.view.isPageRefresh(this);
    this.visitCachedSnapshot = d;
    this.willRender = u;
    this.updateHistory = m;
    this.scrolled = !u;
    this.shouldCacheSnapshot = f;
    this.acceptsStreamResponse = g;
    this.direction = b || p[i];
  }
  get adapter() {
    return this.delegate.adapter;
  }
  get view() {
    return this.delegate.view;
  }
  get history() {
    return this.delegate.history;
  }
  get restorationData() {
    return this.history.getRestorationDataForIdentifier(
      this.restorationIdentifier,
    );
  }
  get silent() {
    return this.isSamePage;
  }
  start() {
    if (this.state == u.initialized) {
      this.recordTimingMetric(d.visitStart);
      this.state = u.started;
      this.adapter.visitStarted(this);
      this.delegate.visitStarted(this);
    }
  }
  cancel() {
    if (this.state == u.started) {
      this.request && this.request.cancel();
      this.cancelRender();
      this.state = u.canceled;
    }
  }
  complete() {
    if (this.state == u.started) {
      this.recordTimingMetric(d.visitEnd);
      this.adapter.visitCompleted(this);
      this.state = u.completed;
      this.followRedirect();
      this.followedRedirect || this.delegate.visitCompleted(this);
    }
  }
  fail() {
    if (this.state == u.started) {
      this.state = u.failed;
      this.adapter.visitFailed(this);
      this.delegate.visitCompleted(this);
    }
  }
  changeHistory() {
    if (!this.historyChanged && this.updateHistory) {
      const e =
        this.location.href === this.referrer?.href ? "replace" : this.action;
      const t = getHistoryMethodForAction(e);
      this.history.update(t, this.location, this.restorationIdentifier);
      this.historyChanged = true;
    }
  }
  issueRequest() {
    if (this.hasPreloadedResponse()) this.simulateRequest();
    else if (this.shouldIssueRequest() && !this.request) {
      this.request = new FetchRequest(this, i.get, this.location);
      this.request.perform();
    }
  }
  simulateRequest() {
    if (this.response) {
      this.startRequest();
      this.recordResponse();
      this.finishRequest();
    }
  }
  startRequest() {
    this.recordTimingMetric(d.requestStart);
    this.adapter.visitRequestStarted(this);
  }
  recordResponse(e = this.response) {
    this.response = e;
    if (e) {
      const { statusCode: t } = e;
      isSuccessful(t)
        ? this.adapter.visitRequestCompleted(this)
        : this.adapter.visitRequestFailedWithStatusCode(this, t);
    }
  }
  finishRequest() {
    this.recordTimingMetric(d.requestEnd);
    this.adapter.visitRequestFinished(this);
  }
  loadResponse() {
    if (this.response) {
      const { statusCode: e, responseHTML: t } = this.response;
      this.render(async () => {
        this.shouldCacheSnapshot && this.cacheSnapshot();
        this.view.renderPromise && (await this.view.renderPromise);
        if (isSuccessful(e) && t != null) {
          const e = PageSnapshot.fromHTMLString(t);
          await this.renderPageSnapshot(e, false);
          this.adapter.visitRendered(this);
          this.complete();
        } else {
          await this.view.renderError(PageSnapshot.fromHTMLString(t), this);
          this.adapter.visitRendered(this);
          this.fail();
        }
      });
    }
  }
  getCachedSnapshot() {
    const e =
      this.view.getCachedSnapshotForLocation(this.location) ||
      this.getPreloadedSnapshot();
    if (
      e &&
      (!getAnchor(this.location) || e.hasAnchor(getAnchor(this.location))) &&
      (this.action == "restore" || e.isPreviewable)
    )
      return e;
  }
  getPreloadedSnapshot() {
    if (this.snapshotHTML)
      return PageSnapshot.fromHTMLString(this.snapshotHTML);
  }
  hasCachedSnapshot() {
    return this.getCachedSnapshot() != null;
  }
  loadCachedSnapshot() {
    const e = this.getCachedSnapshot();
    if (e) {
      const t = this.shouldIssueRequest();
      this.render(async () => {
        this.cacheSnapshot();
        if (this.isSamePage || this.isPageRefresh)
          this.adapter.visitRendered(this);
        else {
          this.view.renderPromise && (await this.view.renderPromise);
          await this.renderPageSnapshot(e, t);
          this.adapter.visitRendered(this);
          t || this.complete();
        }
      });
    }
  }
  followRedirect() {
    if (
      this.redirectedToLocation &&
      !this.followedRedirect &&
      this.response?.redirected
    ) {
      this.adapter.visitProposedToLocation(this.redirectedToLocation, {
        action: "replace",
        response: this.response,
        shouldCacheSnapshot: false,
        willRender: false,
      });
      this.followedRedirect = true;
    }
  }
  goToSamePageAnchor() {
    this.isSamePage &&
      this.render(async () => {
        this.cacheSnapshot();
        this.performScroll();
        this.changeHistory();
        this.adapter.visitRendered(this);
      });
  }
  prepareRequest(e) {
    this.acceptsStreamResponse &&
      e.acceptResponseType(StreamMessage.contentType);
  }
  requestStarted() {
    this.startRequest();
  }
  requestPreventedHandlingResponse(e, t) {}
  async requestSucceededWithResponse(e, t) {
    const r = await t.responseHTML;
    const { redirected: s, statusCode: i } = t;
    if (r == void 0)
      this.recordResponse({ statusCode: m.contentTypeMismatch, redirected: s });
    else {
      this.redirectedToLocation = t.redirected ? t.location : void 0;
      this.recordResponse({ statusCode: i, responseHTML: r, redirected: s });
    }
  }
  async requestFailedWithResponse(e, t) {
    const r = await t.responseHTML;
    const { redirected: s, statusCode: i } = t;
    r == void 0
      ? this.recordResponse({
          statusCode: m.contentTypeMismatch,
          redirected: s,
        })
      : this.recordResponse({ statusCode: i, responseHTML: r, redirected: s });
  }
  requestErrored(e, t) {
    this.recordResponse({ statusCode: m.networkFailure, redirected: false });
  }
  requestFinished() {
    this.finishRequest();
  }
  performScroll() {
    if (
      !this.scrolled &&
      !this.view.forceReloaded &&
      !this.view.shouldPreserveScrollPosition(this)
    ) {
      this.action == "restore"
        ? this.scrollToRestoredPosition() ||
          this.scrollToAnchor() ||
          this.view.scrollToTop()
        : this.scrollToAnchor() || this.view.scrollToTop();
      this.isSamePage &&
        this.delegate.visitScrolledToSamePageLocation(
          this.view.lastRenderedLocation,
          this.location,
        );
      this.scrolled = true;
    }
  }
  scrollToRestoredPosition() {
    const { scrollPosition: e } = this.restorationData;
    if (e) {
      this.view.scrollToPosition(e);
      return true;
    }
  }
  scrollToAnchor() {
    const e = getAnchor(this.location);
    if (e != null) {
      this.view.scrollToAnchor(e);
      return true;
    }
  }
  recordTimingMetric(e) {
    this.timingMetrics[e] = new Date().getTime();
  }
  getTimingMetrics() {
    return { ...this.timingMetrics };
  }
  getHistoryMethodForAction(e) {
    switch (e) {
      case "replace":
        return history.replaceState;
      case "advance":
      case "restore":
        return history.pushState;
    }
  }
  hasPreloadedResponse() {
    return typeof this.response == "object";
  }
  shouldIssueRequest() {
    return (
      !this.isSamePage &&
      (this.action == "restore" ? !this.hasCachedSnapshot() : this.willRender)
    );
  }
  cacheSnapshot() {
    if (!this.snapshotCached) {
      this.view
        .cacheSnapshot(this.snapshot)
        .then((e) => e && this.visitCachedSnapshot(e));
      this.snapshotCached = true;
    }
  }
  async render(e) {
    this.cancelRender();
    this.frame = await nextRepaint();
    await e();
    delete this.frame;
  }
  async renderPageSnapshot(e, t) {
    await this.viewTransitioner.renderChange(
      this.view.shouldTransitionTo(e),
      async () => {
        await this.view.renderPage(e, t, this.willRender, this);
        this.performScroll();
      },
    );
  }
  cancelRender() {
    if (this.frame) {
      cancelAnimationFrame(this.frame);
      delete this.frame;
    }
  }
}
function isSuccessful(e) {
  return e >= 200 && e < 300;
}
class BrowserAdapter {
  progressBar = new ProgressBar();
  constructor(e) {
    this.session = e;
  }
  visitProposedToLocation(e, t) {
    locationIsVisitable(e, this.navigator.rootLocation)
      ? this.navigator.startVisit(e, t?.restorationIdentifier || uuid(), t)
      : (window.location.href = e.toString());
  }
  visitStarted(e) {
    this.location = e.location;
    e.loadCachedSnapshot();
    e.issueRequest();
    e.goToSamePageAnchor();
  }
  visitRequestStarted(e) {
    this.progressBar.setValue(0);
    e.hasCachedSnapshot() || e.action != "restore"
      ? this.showVisitProgressBarAfterDelay()
      : this.showProgressBar();
  }
  visitRequestCompleted(e) {
    e.loadResponse();
  }
  visitRequestFailedWithStatusCode(e, t) {
    switch (t) {
      case m.networkFailure:
      case m.timeoutFailure:
      case m.contentTypeMismatch:
        return this.reload({
          reason: "request_failed",
          context: { statusCode: t },
        });
      default:
        return e.loadResponse();
    }
  }
  visitRequestFinished(e) {}
  visitCompleted(e) {
    this.progressBar.setValue(1);
    this.hideVisitProgressBar();
  }
  pageInvalidated(e) {
    this.reload(e);
  }
  visitFailed(e) {
    this.progressBar.setValue(1);
    this.hideVisitProgressBar();
  }
  visitRendered(e) {}
  formSubmissionStarted(e) {
    this.progressBar.setValue(0);
    this.showFormProgressBarAfterDelay();
  }
  formSubmissionFinished(e) {
    this.progressBar.setValue(1);
    this.hideFormProgressBar();
  }
  showVisitProgressBarAfterDelay() {
    this.visitProgressBarTimeout = window.setTimeout(
      this.showProgressBar,
      this.session.progressBarDelay,
    );
  }
  hideVisitProgressBar() {
    this.progressBar.hide();
    if (this.visitProgressBarTimeout != null) {
      window.clearTimeout(this.visitProgressBarTimeout);
      delete this.visitProgressBarTimeout;
    }
  }
  showFormProgressBarAfterDelay() {
    this.formProgressBarTimeout == null &&
      (this.formProgressBarTimeout = window.setTimeout(
        this.showProgressBar,
        this.session.progressBarDelay,
      ));
  }
  hideFormProgressBar() {
    this.progressBar.hide();
    if (this.formProgressBarTimeout != null) {
      window.clearTimeout(this.formProgressBarTimeout);
      delete this.formProgressBarTimeout;
    }
  }
  showProgressBar = () => {
    this.progressBar.show();
  };
  reload(e) {
    dispatch("turbo:reload", { detail: e });
    window.location.href = this.location?.toString() || window.location.href;
  }
  get navigator() {
    return this.session.navigator;
  }
}
class CacheObserver {
  selector = "[data-turbo-temporary]";
  deprecatedSelector = "[data-turbo-cache=false]";
  started = false;
  start() {
    if (!this.started) {
      this.started = true;
      addEventListener(
        "turbo:before-cache",
        this.removeTemporaryElements,
        false,
      );
    }
  }
  stop() {
    if (this.started) {
      this.started = false;
      removeEventListener(
        "turbo:before-cache",
        this.removeTemporaryElements,
        false,
      );
    }
  }
  removeTemporaryElements = (e) => {
    for (const e of this.temporaryElements) e.remove();
  };
  get temporaryElements() {
    return [
      ...document.querySelectorAll(this.selector),
      ...this.temporaryElementsWithDeprecation,
    ];
  }
  get temporaryElementsWithDeprecation() {
    const e = document.querySelectorAll(this.deprecatedSelector);
    e.length &&
      console.warn(
        `The ${this.deprecatedSelector} selector is deprecated and will be removed in a future version. Use ${this.selector} instead.`,
      );
    return [...e];
  }
}
class FrameRedirector {
  constructor(e, t) {
    this.session = e;
    this.element = t;
    this.linkInterceptor = new LinkInterceptor(this, t);
    this.formSubmitObserver = new FormSubmitObserver(this, t);
  }
  start() {
    this.linkInterceptor.start();
    this.formSubmitObserver.start();
  }
  stop() {
    this.linkInterceptor.stop();
    this.formSubmitObserver.stop();
  }
  shouldInterceptLinkClick(e, t, r) {
    return this.#h(e);
  }
  linkClickIntercepted(e, t, r) {
    const s = this.#d(e);
    s && s.delegate.linkClickIntercepted(e, t, r);
  }
  willSubmitForm(e, t) {
    return e.closest("turbo-frame") == null && this.#u(e, t) && this.#h(e, t);
  }
  formSubmitted(e, t) {
    const r = this.#d(e, t);
    r && r.delegate.formSubmitted(e, t);
  }
  #u(e, t) {
    const r = getAction$1(e, t);
    const s = this.element.ownerDocument.querySelector(
      'meta[name="turbo-root"]',
    );
    const i = expandURL(s?.content ?? "/");
    return this.#h(e, t) && locationIsVisitable(r, i);
  }
  #h(e, t) {
    const r =
      e instanceof HTMLFormElement
        ? this.session.submissionIsNavigatable(e, t)
        : this.session.elementIsNavigatable(e);
    if (r) {
      const r = this.#d(e, t);
      return !!r && r != e.closest("turbo-frame");
    }
    return false;
  }
  #d(e, t) {
    const r =
      t?.getAttribute("data-turbo-frame") || e.getAttribute("data-turbo-frame");
    if (r && r != "_top") {
      const e = this.element.querySelector(`#${r}:not([disabled])`);
      if (e instanceof FrameElement) return e;
    }
  }
}
class History {
  location;
  restorationIdentifier = uuid();
  restorationData = {};
  started = false;
  pageLoaded = false;
  currentIndex = 0;
  constructor(e) {
    this.delegate = e;
  }
  start() {
    if (!this.started) {
      addEventListener("popstate", this.onPopState, false);
      addEventListener("load", this.onPageLoad, false);
      this.currentIndex = history.state?.turbo?.restorationIndex || 0;
      this.started = true;
      this.replace(new URL(window.location.href));
    }
  }
  stop() {
    if (this.started) {
      removeEventListener("popstate", this.onPopState, false);
      removeEventListener("load", this.onPageLoad, false);
      this.started = false;
    }
  }
  push(e, t) {
    this.update(history.pushState, e, t);
  }
  replace(e, t) {
    this.update(history.replaceState, e, t);
  }
  update(e, t, r = uuid()) {
    e === history.pushState && ++this.currentIndex;
    const s = {
      turbo: { restorationIdentifier: r, restorationIndex: this.currentIndex },
    };
    e.call(history, s, "", t.href);
    this.location = t;
    this.restorationIdentifier = r;
  }
  getRestorationDataForIdentifier(e) {
    return this.restorationData[e] || {};
  }
  updateRestorationData(e) {
    const { restorationIdentifier: t } = this;
    const r = this.restorationData[t];
    this.restorationData[t] = { ...r, ...e };
  }
  assumeControlOfScrollRestoration() {
    if (!this.previousScrollRestoration) {
      this.previousScrollRestoration = history.scrollRestoration ?? "auto";
      history.scrollRestoration = "manual";
    }
  }
  relinquishControlOfScrollRestoration() {
    if (this.previousScrollRestoration) {
      history.scrollRestoration = this.previousScrollRestoration;
      delete this.previousScrollRestoration;
    }
  }
  onPopState = (e) => {
    if (this.shouldHandlePopState()) {
      const { turbo: t } = e.state || {};
      if (t) {
        this.location = new URL(window.location.href);
        const { restorationIdentifier: e, restorationIndex: r } = t;
        this.restorationIdentifier = e;
        const s = r > this.currentIndex ? "forward" : "back";
        this.delegate.historyPoppedToLocationWithRestorationIdentifierAndDirection(
          this.location,
          e,
          s,
        );
        this.currentIndex = r;
      }
    }
  };
  onPageLoad = async (e) => {
    await nextMicrotask();
    this.pageLoaded = true;
  };
  shouldHandlePopState() {
    return this.pageIsLoaded();
  }
  pageIsLoaded() {
    return this.pageLoaded || document.readyState == "complete";
  }
}
class LinkPrefetchObserver {
  started = false;
  #m = null;
  constructor(e, t) {
    this.delegate = e;
    this.eventTarget = t;
  }
  start() {
    this.started ||
      (this.eventTarget.readyState === "loading"
        ? this.eventTarget.addEventListener("DOMContentLoaded", this.#p, {
            once: true,
          })
        : this.#p());
  }
  stop() {
    if (this.started) {
      this.eventTarget.removeEventListener("mouseenter", this.#f, {
        capture: true,
        passive: true,
      });
      this.eventTarget.removeEventListener("mouseleave", this.#g, {
        capture: true,
        passive: true,
      });
      this.eventTarget.removeEventListener(
        "turbo:before-fetch-request",
        this.#b,
        true,
      );
      this.started = false;
    }
  }
  #p = () => {
    this.eventTarget.addEventListener("mouseenter", this.#f, {
      capture: true,
      passive: true,
    });
    this.eventTarget.addEventListener("mouseleave", this.#g, {
      capture: true,
      passive: true,
    });
    this.eventTarget.addEventListener(
      "turbo:before-fetch-request",
      this.#b,
      true,
    );
    this.started = true;
  };
  #f = (e) => {
    if (getMetaContent("turbo-prefetch") === "false") return;
    const t = e.target;
    const r =
      t.matches && t.matches("a[href]:not([target^=_]):not([download])");
    if (r && this.#v(t)) {
      const e = t;
      const r = getLocationForLink(e);
      if (this.delegate.canPrefetchRequestToLocation(e, r)) {
        this.#m = e;
        const s = new FetchRequest(this, i.get, r, new URLSearchParams(), t);
        c.setLater(r.toString(), s, this.#S);
      }
    }
  };
  #g = (e) => {
    e.target === this.#m && this.#E();
  };
  #E = () => {
    c.clear();
    this.#m = null;
  };
  #b = (e) => {
    if (e.target.tagName !== "FORM" && e.detail.fetchOptions.method === "GET") {
      const t = c.get(e.detail.url.toString());
      t && (e.detail.fetchRequest = t);
      c.clear();
    }
  };
  prepareRequest(e) {
    const t = e.target;
    e.headers["X-Sec-Purpose"] = "prefetch";
    const r = t.closest("turbo-frame");
    const s =
      t.getAttribute("data-turbo-frame") || r?.getAttribute("target") || r?.id;
    s && s !== "_top" && (e.headers["Turbo-Frame"] = s);
  }
  requestSucceededWithResponse() {}
  requestStarted(e) {}
  requestErrored(e) {}
  requestFinished(e) {}
  requestPreventedHandlingResponse(e, t) {}
  requestFailedWithResponse(e, t) {}
  get #S() {
    return Number(getMetaContent("turbo-prefetch-cache-time")) || a;
  }
  #v(e) {
    const t = e.getAttribute("href");
    return (
      !!t &&
      !unfetchableLink(e) &&
      !linkToTheSamePage(e) &&
      !linkOptsOut(e) &&
      !nonSafeLink(e) &&
      !eventPrevented(e)
    );
  }
}
const unfetchableLink = (e) =>
  e.origin !== document.location.origin ||
  !["http:", "https:"].includes(e.protocol) ||
  e.hasAttribute("target");
const linkToTheSamePage = (e) =>
  e.pathname + e.search ===
    document.location.pathname + document.location.search ||
  e.href.startsWith("#");
const linkOptsOut = (e) => {
  if (e.getAttribute("data-turbo-prefetch") === "false") return true;
  if (e.getAttribute("data-turbo") === "false") return true;
  const t = findClosestRecursively(e, "[data-turbo-prefetch]");
  return !(!t || t.getAttribute("data-turbo-prefetch") !== "false");
};
const nonSafeLink = (e) => {
  const t = e.getAttribute("data-turbo-method");
  return (
    !(!t || t.toLowerCase() === "get") ||
    !!isUJS(e) ||
    !!e.hasAttribute("data-turbo-confirm") ||
    !!e.hasAttribute("data-turbo-stream")
  );
};
const isUJS = (e) =>
  e.hasAttribute("data-remote") ||
  e.hasAttribute("data-behavior") ||
  e.hasAttribute("data-confirm") ||
  e.hasAttribute("data-method");
const eventPrevented = (e) => {
  const t = dispatch("turbo:before-prefetch", { target: e, cancelable: true });
  return t.defaultPrevented;
};
class Navigator {
  constructor(e) {
    this.delegate = e;
  }
  proposeVisit(e, t = {}) {
    this.delegate.allowsVisitingLocationWithAction(e, t.action) &&
      this.delegate.visitProposedToLocation(e, t);
  }
  startVisit(e, t, r = {}) {
    this.stop();
    this.currentVisit = new Visit(this, expandURL(e), t, {
      referrer: this.location,
      ...r,
    });
    this.currentVisit.start();
  }
  submitForm(e, t) {
    this.stop();
    this.formSubmission = new FormSubmission(this, e, t, true);
    this.formSubmission.start();
  }
  stop() {
    if (this.formSubmission) {
      this.formSubmission.stop();
      delete this.formSubmission;
    }
    if (this.currentVisit) {
      this.currentVisit.cancel();
      delete this.currentVisit;
    }
  }
  get adapter() {
    return this.delegate.adapter;
  }
  get view() {
    return this.delegate.view;
  }
  get rootLocation() {
    return this.view.snapshot.rootLocation;
  }
  get history() {
    return this.delegate.history;
  }
  formSubmissionStarted(e) {
    typeof this.adapter.formSubmissionStarted === "function" &&
      this.adapter.formSubmissionStarted(e);
  }
  async formSubmissionSucceededWithResponse(e, t) {
    if (e == this.formSubmission) {
      const r = await t.responseHTML;
      if (r) {
        const s = e.isSafe;
        s || this.view.clearSnapshotCache();
        const { statusCode: i, redirected: n } = t;
        const o = this.#w(e, t);
        const a = {
          action: o,
          shouldCacheSnapshot: s,
          response: { statusCode: i, responseHTML: r, redirected: n },
        };
        this.proposeVisit(t.location, a);
      }
    }
  }
  async formSubmissionFailedWithResponse(e, t) {
    const r = await t.responseHTML;
    if (r) {
      const e = PageSnapshot.fromHTMLString(r);
      t.serverError
        ? await this.view.renderError(e, this.currentVisit)
        : await this.view.renderPage(e, false, true, this.currentVisit);
      e.shouldPreserveScrollPosition || this.view.scrollToTop();
      this.view.clearSnapshotCache();
    }
  }
  formSubmissionErrored(e, t) {
    console.error(t);
  }
  formSubmissionFinished(e) {
    typeof this.adapter.formSubmissionFinished === "function" &&
      this.adapter.formSubmissionFinished(e);
  }
  visitStarted(e) {
    this.delegate.visitStarted(e);
  }
  visitCompleted(e) {
    this.delegate.visitCompleted(e);
    delete this.currentVisit;
  }
  locationWithActionIsSamePage(e, t) {
    const r = getAnchor(e);
    const s = getAnchor(this.view.lastRenderedLocation);
    const i = t === "restore" && typeof r === "undefined";
    return (
      t !== "replace" &&
      getRequestURL(e) === getRequestURL(this.view.lastRenderedLocation) &&
      (i || (r != null && r !== s))
    );
  }
  visitScrolledToSamePageLocation(e, t) {
    this.delegate.visitScrolledToSamePageLocation(e, t);
  }
  get location() {
    return this.history.location;
  }
  get restorationIdentifier() {
    return this.history.restorationIdentifier;
  }
  #w(e, t) {
    const { submitter: r, formElement: s } = e;
    return getVisitAction(r, s) || this.#y(t);
  }
  #y(e) {
    const t = e.redirected && e.location.href === this.location?.href;
    return t ? "replace" : "advance";
  }
}
const f = { initial: 0, loading: 1, interactive: 2, complete: 3 };
class PageObserver {
  stage = f.initial;
  started = false;
  constructor(e) {
    this.delegate = e;
  }
  start() {
    if (!this.started) {
      this.stage == f.initial && (this.stage = f.loading);
      document.addEventListener(
        "readystatechange",
        this.interpretReadyState,
        false,
      );
      addEventListener("pagehide", this.pageWillUnload, false);
      this.started = true;
    }
  }
  stop() {
    if (this.started) {
      document.removeEventListener(
        "readystatechange",
        this.interpretReadyState,
        false,
      );
      removeEventListener("pagehide", this.pageWillUnload, false);
      this.started = false;
    }
  }
  interpretReadyState = () => {
    const { readyState: e } = this;
    e == "interactive"
      ? this.pageIsInteractive()
      : e == "complete" && this.pageIsComplete();
  };
  pageIsInteractive() {
    if (this.stage == f.loading) {
      this.stage = f.interactive;
      this.delegate.pageBecameInteractive();
    }
  }
  pageIsComplete() {
    this.pageIsInteractive();
    if (this.stage == f.interactive) {
      this.stage = f.complete;
      this.delegate.pageLoaded();
    }
  }
  pageWillUnload = () => {
    this.delegate.pageWillUnload();
  };
  get readyState() {
    return document.readyState;
  }
}
class ScrollObserver {
  started = false;
  constructor(e) {
    this.delegate = e;
  }
  start() {
    if (!this.started) {
      addEventListener("scroll", this.onScroll, false);
      this.onScroll();
      this.started = true;
    }
  }
  stop() {
    if (this.started) {
      removeEventListener("scroll", this.onScroll, false);
      this.started = false;
    }
  }
  onScroll = () => {
    this.updatePosition({ x: window.pageXOffset, y: window.pageYOffset });
  };
  updatePosition(e) {
    this.delegate.scrollPositionChanged(e);
  }
}
class StreamMessageRenderer {
  render({ fragment: e }) {
    Bardo.preservingPermanentElements(
      this,
      getPermanentElementMapForFragment(e),
      () => {
        withAutofocusFromFragment(e, () => {
          withPreservedFocus(() => {
            document.documentElement.appendChild(e);
          });
        });
      },
    );
  }
  enteringBardo(e, t) {
    t.replaceWith(e.cloneNode(true));
  }
  leavingBardo() {}
}
function getPermanentElementMapForFragment(e) {
  const t = queryPermanentElementsAll(document.documentElement);
  const r = {};
  for (const s of t) {
    const { id: t } = s;
    for (const i of e.querySelectorAll("turbo-stream")) {
      const e = getPermanentElementById(i.templateElement.content, t);
      e && (r[t] = [s, e]);
    }
  }
  return r;
}
async function withAutofocusFromFragment(e, t) {
  const r = `turbo-stream-autofocus-${uuid()}`;
  const s = e.querySelectorAll("turbo-stream");
  const i = firstAutofocusableElementInStreams(s);
  let n = null;
  if (i) {
    n = i.id ? i.id : r;
    i.id = n;
  }
  t();
  await nextRepaint();
  const o =
    document.activeElement == null || document.activeElement == document.body;
  if (o && n) {
    const e = document.getElementById(n);
    elementIsFocusable(e) && e.focus();
    e && e.id == r && e.removeAttribute("id");
  }
}
async function withPreservedFocus(e) {
  const [t, r] = await around(e, () => document.activeElement);
  const s = t && t.id;
  if (s) {
    const e = document.getElementById(s);
    elementIsFocusable(e) && e != r && e.focus();
  }
}
function firstAutofocusableElementInStreams(e) {
  for (const t of e) {
    const e = queryAutofocusableElement(t.templateElement.content);
    if (e) return e;
  }
  return null;
}
class StreamObserver {
  sources = new Set();
  #R = false;
  constructor(e) {
    this.delegate = e;
  }
  start() {
    if (!this.#R) {
      this.#R = true;
      addEventListener(
        "turbo:before-fetch-response",
        this.inspectFetchResponse,
        false,
      );
    }
  }
  stop() {
    if (this.#R) {
      this.#R = false;
      removeEventListener(
        "turbo:before-fetch-response",
        this.inspectFetchResponse,
        false,
      );
    }
  }
  connectStreamSource(e) {
    if (!this.streamSourceIsConnected(e)) {
      this.sources.add(e);
      e.addEventListener("message", this.receiveMessageEvent, false);
    }
  }
  disconnectStreamSource(e) {
    if (this.streamSourceIsConnected(e)) {
      this.sources.delete(e);
      e.removeEventListener("message", this.receiveMessageEvent, false);
    }
  }
  streamSourceIsConnected(e) {
    return this.sources.has(e);
  }
  inspectFetchResponse = (e) => {
    const t = fetchResponseFromEvent(e);
    if (t && fetchResponseIsStream(t)) {
      e.preventDefault();
      this.receiveMessageResponse(t);
    }
  };
  receiveMessageEvent = (e) => {
    this.#R && typeof e.data == "string" && this.receiveMessageHTML(e.data);
  };
  async receiveMessageResponse(e) {
    const t = await e.responseHTML;
    t && this.receiveMessageHTML(t);
  }
  receiveMessageHTML(e) {
    this.delegate.receivedMessageFromStream(StreamMessage.wrap(e));
  }
}
function fetchResponseFromEvent(e) {
  const t = e.detail?.fetchResponse;
  if (t instanceof FetchResponse) return t;
}
function fetchResponseIsStream(e) {
  const t = e.contentType ?? "";
  return t.startsWith(StreamMessage.contentType);
}
class ErrorRenderer extends Renderer {
  static renderElement(e, t) {
    const { documentElement: r, body: s } = document;
    r.replaceChild(t, s);
  }
  async render() {
    this.replaceHeadAndBody();
    this.activateScriptElements();
  }
  replaceHeadAndBody() {
    const { documentElement: e, head: t } = document;
    e.replaceChild(this.newHead, t);
    this.renderElement(this.currentElement, this.newElement);
  }
  activateScriptElements() {
    for (const e of this.scriptElements) {
      const t = e.parentNode;
      if (t) {
        const r = activateScriptElement(e);
        t.replaceChild(r, e);
      }
    }
  }
  get newHead() {
    return this.newSnapshot.headSnapshot.element;
  }
  get scriptElements() {
    return document.documentElement.querySelectorAll("script");
  }
}
var g = (function () {
  let e = new Set();
  let t = {
    morphStyle: "outerHTML",
    callbacks: {
      beforeNodeAdded: noOp,
      afterNodeAdded: noOp,
      beforeNodeMorphed: noOp,
      afterNodeMorphed: noOp,
      beforeNodeRemoved: noOp,
      afterNodeRemoved: noOp,
      beforeAttributeUpdated: noOp,
    },
    head: {
      style: "merge",
      shouldPreserve: function (e) {
        return e.getAttribute("im-preserve") === "true";
      },
      shouldReAppend: function (e) {
        return e.getAttribute("im-re-append") === "true";
      },
      shouldRemove: noOp,
      afterHeadMorphed: noOp,
    },
  };
  function morph(e, t, r = {}) {
    e instanceof Document && (e = e.documentElement);
    typeof t === "string" && (t = parseContent(t));
    let s = normalizeContent(t);
    let i = createMorphContext(e, s, r);
    return morphNormalizedContent(e, s, i);
  }
  function morphNormalizedContent(e, t, r) {
    if (r.head.block) {
      let s = e.querySelector("head");
      let i = t.querySelector("head");
      if (s && i) {
        let n = handleHeadElement(i, s, r);
        Promise.all(n).then(function () {
          morphNormalizedContent(
            e,
            t,
            Object.assign(r, { head: { block: false, ignore: true } }),
          );
        });
        return;
      }
    }
    if (r.morphStyle === "innerHTML") {
      morphChildren(t, e, r);
      return e.children;
    }
    if (r.morphStyle === "outerHTML" || r.morphStyle == null) {
      let s = findBestNodeMatch(t, e, r);
      let i = s?.previousSibling;
      let n = s?.nextSibling;
      let o = morphOldNodeTo(e, s, r);
      return s ? insertSiblings(i, o, n) : [];
    }
    throw "Do not understand how to morph style " + r.morphStyle;
  }
  /**
   * @param possibleActiveElement
   * @param ctx
   * @returns {boolean}
   */ function ignoreValueOfActiveElement(e, t) {
    return (
      t.ignoreActiveValue && e === document.activeElement && e !== document.body
    );
  }
  /**
   * @param oldNode root node to merge content into
   * @param newContent new content to merge
   * @param ctx the merge context
   * @returns {Element} the element that ended up in the DOM
   */ function morphOldNodeTo(e, t, r) {
    if (!r.ignoreActive || e !== document.activeElement) {
      if (t == null) {
        if (r.callbacks.beforeNodeRemoved(e) === false) return e;
        e.remove();
        r.callbacks.afterNodeRemoved(e);
        return null;
      }
      if (isSoftMatch(e, t)) {
        if (r.callbacks.beforeNodeMorphed(e, t) === false) return e;
        if (e instanceof HTMLHeadElement && r.head.ignore);
        else if (e instanceof HTMLHeadElement && r.head.style !== "morph")
          handleHeadElement(t, e, r);
        else {
          syncNodeFrom(t, e, r);
          ignoreValueOfActiveElement(e, r) || morphChildren(t, e, r);
        }
        r.callbacks.afterNodeMorphed(e, t);
        return e;
      }
      if (r.callbacks.beforeNodeRemoved(e) === false) return e;
      if (r.callbacks.beforeNodeAdded(t) === false) return e;
      e.parentElement.replaceChild(t, e);
      r.callbacks.afterNodeAdded(t);
      r.callbacks.afterNodeRemoved(e);
      return t;
    }
  }
  /**
   * This is the core algorithm for matching up children.  The idea is to use id sets to try to match up
   * nodes as faithfully as possible.  We greedily match, which allows us to keep the algorithm fast, but
   * by using id sets, we are able to better match up with content deeper in the DOM.
   *
   * Basic algorithm is, for each node in the new content:
   *
   * - if we have reached the end of the old parent, append the new content
   * - if the new content has an id set match with the current insertion point, morph
   * - search for an id set match
   * - if id set match found, morph
   * - otherwise search for a "soft" match
   * - if a soft match is found, morph
   * - otherwise, prepend the new node before the current insertion point
   *
   * The two search algorithms terminate if competing node matches appear to outweigh what can be achieved
   * with the current node.  See findIdSetMatch() and findSoftMatch() for details.
   *
   * @param {Element} newParent the parent element of the new content
   * @param {Element } oldParent the old content that we are merging the new content into
   * @param ctx the merge context
   */ function morphChildren(e, t, r) {
    let s = e.firstChild;
    let i = t.firstChild;
    let n;
    while (s) {
      n = s;
      s = n.nextSibling;
      if (i == null) {
        if (r.callbacks.beforeNodeAdded(n) === false) return;
        t.appendChild(n);
        r.callbacks.afterNodeAdded(n);
        removeIdsFromConsideration(r, n);
        continue;
      }
      if (isIdSetMatch(n, i, r)) {
        morphOldNodeTo(i, n, r);
        i = i.nextSibling;
        removeIdsFromConsideration(r, n);
        continue;
      }
      let o = findIdSetMatch(e, t, n, i, r);
      if (o) {
        i = removeNodesBetween(i, o, r);
        morphOldNodeTo(o, n, r);
        removeIdsFromConsideration(r, n);
        continue;
      }
      let a = findSoftMatch(e, t, n, i, r);
      if (a) {
        i = removeNodesBetween(i, a, r);
        morphOldNodeTo(a, n, r);
        removeIdsFromConsideration(r, n);
      } else {
        if (r.callbacks.beforeNodeAdded(n) === false) return;
        t.insertBefore(n, i);
        r.callbacks.afterNodeAdded(n);
        removeIdsFromConsideration(r, n);
      }
    }
    while (i !== null) {
      let e = i;
      i = i.nextSibling;
      removeNode(e, r);
    }
  }
  /**
   * @param attr {String} the attribute to be mutated
   * @param to {Element} the element that is going to be updated
   * @param updateType {("update"|"remove")}
   * @param ctx the merge context
   * @returns {boolean} true if the attribute should be ignored, false otherwise
   */ function ignoreAttribute(e, t, r, s) {
    return (
      !(
        e !== "value" ||
        !s.ignoreActiveValue ||
        t !== document.activeElement
      ) || s.callbacks.beforeAttributeUpdated(e, t, r) === false
    );
  }
  /**
   * syncs a given node with another node, copying over all attributes and
   * inner element state from the 'from' node to the 'to' node
   *
   * @param {Element} from the element to copy attributes & state from
   * @param {Element} to the element to copy attributes & state to
   * @param ctx the merge context
   */ function syncNodeFrom(e, t, r) {
    let s = e.nodeType;
    if (s === 1) {
      const s = e.attributes;
      const i = t.attributes;
      for (const e of s)
        ignoreAttribute(e.name, t, "update", r) ||
          (t.getAttribute(e.name) !== e.value &&
            t.setAttribute(e.name, e.value));
      for (let s = i.length - 1; 0 <= s; s--) {
        const n = i[s];
        ignoreAttribute(n.name, t, "remove", r) ||
          e.hasAttribute(n.name) ||
          t.removeAttribute(n.name);
      }
    }
    (s !== 8 && s !== 3) ||
      (t.nodeValue !== e.nodeValue && (t.nodeValue = e.nodeValue));
    ignoreValueOfActiveElement(t, r) || syncInputValue(e, t, r);
  }
  /**
   * @param from {Element} element to sync the value from
   * @param to {Element} element to sync the value to
   * @param attributeName {String} the attribute name
   * @param ctx the merge context
   */ function syncBooleanAttribute(e, t, r, s) {
    if (e[r] !== t[r]) {
      let i = ignoreAttribute(r, t, "update", s);
      i || (t[r] = e[r]);
      e[r]
        ? i || t.setAttribute(r, e[r])
        : ignoreAttribute(r, t, "remove", s) || t.removeAttribute(r);
    }
  }
  /**
   * NB: many bothans died to bring us information:
   *
   *  https://github.com/patrick-steele-idem/morphdom/blob/master/src/specialElHandlers.js
   *  https://github.com/choojs/nanomorph/blob/master/lib/morph.jsL113
   *
   * @param from {Element} the element to sync the input value from
   * @param to {Element} the element to sync the input value to
   * @param ctx the merge context
   */ function syncInputValue(e, t, r) {
    if (
      e instanceof HTMLInputElement &&
      t instanceof HTMLInputElement &&
      e.type !== "file"
    ) {
      let s = e.value;
      let i = t.value;
      syncBooleanAttribute(e, t, "checked", r);
      syncBooleanAttribute(e, t, "disabled", r);
      if (e.hasAttribute("value")) {
        if (s !== i && !ignoreAttribute("value", t, "update", r)) {
          t.setAttribute("value", s);
          t.value = s;
        }
      } else if (!ignoreAttribute("value", t, "remove", r)) {
        t.value = "";
        t.removeAttribute("value");
      }
    } else if (e instanceof HTMLOptionElement)
      syncBooleanAttribute(e, t, "selected", r);
    else if (
      e instanceof HTMLTextAreaElement &&
      t instanceof HTMLTextAreaElement
    ) {
      let s = e.value;
      let i = t.value;
      if (ignoreAttribute("value", t, "update", r)) return;
      s !== i && (t.value = s);
      t.firstChild &&
        t.firstChild.nodeValue !== s &&
        (t.firstChild.nodeValue = s);
    }
  }
  function handleHeadElement(e, t, r) {
    let s = [];
    let i = [];
    let n = [];
    let o = [];
    let a = r.head.style;
    let c = new Map();
    for (const t of e.children) c.set(t.outerHTML, t);
    for (const e of t.children) {
      let t = c.has(e.outerHTML);
      let s = r.head.shouldReAppend(e);
      let l = r.head.shouldPreserve(e);
      if (t || l)
        if (s) i.push(e);
        else {
          c.delete(e.outerHTML);
          n.push(e);
        }
      else if (a === "append") {
        if (s) {
          i.push(e);
          o.push(e);
        }
      } else r.head.shouldRemove(e) !== false && i.push(e);
    }
    o.push(...c.values());
    let l = [];
    for (const e of o) {
      let i = document
        .createRange()
        .createContextualFragment(e.outerHTML).firstChild;
      if (r.callbacks.beforeNodeAdded(i) !== false) {
        if (i.href || i.src) {
          let e = null;
          let t = new Promise(function (t) {
            e = t;
          });
          i.addEventListener("load", function () {
            e();
          });
          l.push(t);
        }
        t.appendChild(i);
        r.callbacks.afterNodeAdded(i);
        s.push(i);
      }
    }
    for (const e of i)
      if (r.callbacks.beforeNodeRemoved(e) !== false) {
        t.removeChild(e);
        r.callbacks.afterNodeRemoved(e);
      }
    r.head.afterHeadMorphed(t, { added: s, kept: n, removed: i });
    return l;
  }
  function noOp() {}
  function mergeDefaults(e) {
    let r = {};
    Object.assign(r, t);
    Object.assign(r, e);
    r.callbacks = {};
    Object.assign(r.callbacks, t.callbacks);
    Object.assign(r.callbacks, e.callbacks);
    r.head = {};
    Object.assign(r.head, t.head);
    Object.assign(r.head, e.head);
    return r;
  }
  function createMorphContext(e, t, r) {
    r = mergeDefaults(r);
    return {
      target: e,
      newContent: t,
      config: r,
      morphStyle: r.morphStyle,
      ignoreActive: r.ignoreActive,
      ignoreActiveValue: r.ignoreActiveValue,
      idMap: createIdMap(e, t),
      deadIds: new Set(),
      callbacks: r.callbacks,
      head: r.head,
    };
  }
  function isIdSetMatch(e, t, r) {
    return (
      e != null &&
      t != null &&
      e.nodeType === t.nodeType &&
      e.tagName === t.tagName &&
      ((e.id !== "" && e.id === t.id) || getIdIntersectionCount(r, e, t) > 0)
    );
  }
  function isSoftMatch(e, t) {
    return (
      e != null &&
      t != null &&
      e.nodeType === t.nodeType &&
      e.tagName === t.tagName
    );
  }
  function removeNodesBetween(e, t, r) {
    while (e !== t) {
      let t = e;
      e = e.nextSibling;
      removeNode(t, r);
    }
    removeIdsFromConsideration(r, t);
    return t.nextSibling;
  }
  function findIdSetMatch(e, t, r, s, i) {
    let n = getIdIntersectionCount(i, r, t);
    let o = null;
    if (n > 0) {
      let t = s;
      let o = 0;
      while (t != null) {
        if (isIdSetMatch(r, t, i)) return t;
        o += getIdIntersectionCount(i, t, e);
        if (o > n) return null;
        t = t.nextSibling;
      }
    }
    return o;
  }
  function findSoftMatch(e, t, r, s, i) {
    let n = s;
    let o = r.nextSibling;
    let a = 0;
    while (n != null) {
      if (getIdIntersectionCount(i, n, e) > 0) return null;
      if (isSoftMatch(r, n)) return n;
      if (isSoftMatch(o, n)) {
        a++;
        o = o.nextSibling;
        if (a >= 2) return null;
      }
      n = n.nextSibling;
    }
    return n;
  }
  function parseContent(e) {
    let t = new DOMParser();
    let r = e.replace(/<svg(\s[^>]*>|>)([\s\S]*?)<\/svg>/gim, "");
    if (r.match(/<\/html>/) || r.match(/<\/head>/) || r.match(/<\/body>/)) {
      let s = t.parseFromString(e, "text/html");
      if (r.match(/<\/html>/)) {
        s.generatedByIdiomorph = true;
        return s;
      }
      {
        let e = s.firstChild;
        if (e) {
          e.generatedByIdiomorph = true;
          return e;
        }
        return null;
      }
    }
    {
      let r = t.parseFromString(
        "<body><template>" + e + "</template></body>",
        "text/html",
      );
      let s = r.body.querySelector("template").content;
      s.generatedByIdiomorph = true;
      return s;
    }
  }
  function normalizeContent(e) {
    if (e == null) {
      const e = document.createElement("div");
      return e;
    }
    if (e.generatedByIdiomorph) return e;
    if (e instanceof Node) {
      const t = document.createElement("div");
      t.append(e);
      return t;
    }
    {
      const t = document.createElement("div");
      for (const r of [...e]) t.append(r);
      return t;
    }
  }
  function insertSiblings(e, t, r) {
    let s = [];
    let i = [];
    while (e != null) {
      s.push(e);
      e = e.previousSibling;
    }
    while (s.length > 0) {
      let e = s.pop();
      i.push(e);
      t.parentElement.insertBefore(e, t);
    }
    i.push(t);
    while (r != null) {
      s.push(r);
      i.push(r);
      r = r.nextSibling;
    }
    while (s.length > 0) t.parentElement.insertBefore(s.pop(), t.nextSibling);
    return i;
  }
  function findBestNodeMatch(e, t, r) {
    let s;
    s = e.firstChild;
    let i = s;
    let n = 0;
    while (s) {
      let e = scoreElement(s, t, r);
      if (e > n) {
        i = s;
        n = e;
      }
      s = s.nextSibling;
    }
    return i;
  }
  function scoreElement(e, t, r) {
    return isSoftMatch(e, t) ? 0.5 + getIdIntersectionCount(r, e, t) : 0;
  }
  function removeNode(e, t) {
    removeIdsFromConsideration(t, e);
    if (t.callbacks.beforeNodeRemoved(e) !== false) {
      e.remove();
      t.callbacks.afterNodeRemoved(e);
    }
  }
  function isIdInConsideration(e, t) {
    return !e.deadIds.has(t);
  }
  function idIsWithinNode(t, r, s) {
    let i = t.idMap.get(s) || e;
    return i.has(r);
  }
  function removeIdsFromConsideration(t, r) {
    let s = t.idMap.get(r) || e;
    for (const e of s) t.deadIds.add(e);
  }
  function getIdIntersectionCount(t, r, s) {
    let i = t.idMap.get(r) || e;
    let n = 0;
    for (const e of i)
      isIdInConsideration(t, e) && idIsWithinNode(t, e, s) && ++n;
    return n;
  }
  /**
   * A bottom up algorithm that finds all elements with ids inside of the node
   * argument and populates id sets for those nodes and all their parents, generating
   * a set of ids contained within all nodes for the entire hierarchy in the DOM
   *
   * @param node {Element}
   * @param {Map<Node, Set<String>>} idMap
   */ function populateIdMapForNode(e, t) {
    let r = e.parentElement;
    let s = e.querySelectorAll("[id]");
    for (const e of s) {
      let s = e;
      while (s !== r && s != null) {
        let r = t.get(s);
        if (r == null) {
          r = new Set();
          t.set(s, r);
        }
        r.add(e.id);
        s = s.parentElement;
      }
    }
  }
  /**
   * This function computes a map of nodes to all ids contained within that node (inclusive of the
   * node).  This map can be used to ask if two nodes have intersecting sets of ids, which allows
   * for a looser definition of "matching" than tradition id matching, and allows child nodes
   * to contribute to a parent nodes matching.
   *
   * @param {Element} oldContent  the old content that will be morphed
   * @param {Element} newContent  the new content to morph to
   * @returns {Map<Node, Set<String>>} a map of nodes to id sets for the
   */ function createIdMap(e, t) {
    let r = new Map();
    populateIdMapForNode(e, r);
    populateIdMapForNode(t, r);
    return r;
  }
  return { morph: morph, defaults: t };
})();
function morphElements(e, t, { callbacks: r, ...s } = {}) {
  g.morph(e, t, { ...s, callbacks: new DefaultIdiomorphCallbacks(r) });
}
function morphChildren(e, t) {
  morphElements(e, t.children, { morphStyle: "innerHTML" });
}
class DefaultIdiomorphCallbacks {
  #A;
  constructor({ beforeNodeMorphed: e } = {}) {
    this.#A = e || (() => true);
  }
  beforeNodeAdded = (e) =>
    !(
      e.id &&
      e.hasAttribute("data-turbo-permanent") &&
      document.getElementById(e.id)
    );
  beforeNodeMorphed = (e, t) => {
    if (e instanceof Element) {
      if (!e.hasAttribute("data-turbo-permanent") && this.#A(e, t)) {
        const r = dispatch("turbo:before-morph-element", {
          cancelable: true,
          target: e,
          detail: { currentElement: e, newElement: t },
        });
        return !r.defaultPrevented;
      }
      return false;
    }
  };
  beforeAttributeUpdated = (e, t, r) => {
    const s = dispatch("turbo:before-morph-attribute", {
      cancelable: true,
      target: t,
      detail: { attributeName: e, mutationType: r },
    });
    return !s.defaultPrevented;
  };
  beforeNodeRemoved = (e) => this.beforeNodeMorphed(e);
  afterNodeMorphed = (e, t) => {
    e instanceof Element &&
      dispatch("turbo:morph-element", {
        target: e,
        detail: { currentElement: e, newElement: t },
      });
  };
}
class MorphingFrameRenderer extends FrameRenderer {
  static renderElement(e, t) {
    dispatch("turbo:before-frame-morph", {
      target: e,
      detail: { currentElement: e, newElement: t },
    });
    morphChildren(e, t);
  }
}
class PageRenderer extends Renderer {
  static renderElement(e, t) {
    document.body && t instanceof HTMLBodyElement
      ? document.body.replaceWith(t)
      : document.documentElement.appendChild(t);
  }
  get shouldRender() {
    return this.newSnapshot.isVisitable && this.trackedElementsAreIdentical;
  }
  get reloadReason() {
    return this.newSnapshot.isVisitable
      ? this.trackedElementsAreIdentical
        ? void 0
        : { reason: "tracked_element_mismatch" }
      : { reason: "turbo_visit_control_is_reload" };
  }
  async prepareToRender() {
    this.#L();
    await this.mergeHead();
  }
  async render() {
    this.willRender && (await this.replaceBody());
  }
  finishRendering() {
    super.finishRendering();
    this.isPreview || this.focusFirstAutofocusableElement();
  }
  get currentHeadSnapshot() {
    return this.currentSnapshot.headSnapshot;
  }
  get newHeadSnapshot() {
    return this.newSnapshot.headSnapshot;
  }
  get newElement() {
    return this.newSnapshot.element;
  }
  #L() {
    const { documentElement: e } = this.currentSnapshot;
    const { lang: t } = this.newSnapshot;
    t ? e.setAttribute("lang", t) : e.removeAttribute("lang");
  }
  async mergeHead() {
    const e = this.mergeProvisionalElements();
    const t = this.copyNewHeadStylesheetElements();
    this.copyNewHeadScriptElements();
    await e;
    await t;
    this.willRender && this.removeUnusedDynamicStylesheetElements();
  }
  async replaceBody() {
    await this.preservingPermanentElements(async () => {
      this.activateNewBody();
      await this.assignNewBody();
    });
  }
  get trackedElementsAreIdentical() {
    return (
      this.currentHeadSnapshot.trackedElementSignature ==
      this.newHeadSnapshot.trackedElementSignature
    );
  }
  async copyNewHeadStylesheetElements() {
    const e = [];
    for (const t of this.newHeadStylesheetElements) {
      e.push(waitForLoad(t));
      document.head.appendChild(t);
    }
    await Promise.all(e);
  }
  copyNewHeadScriptElements() {
    for (const e of this.newHeadScriptElements)
      document.head.appendChild(activateScriptElement(e));
  }
  removeUnusedDynamicStylesheetElements() {
    for (const e of this.unusedDynamicStylesheetElements)
      document.head.removeChild(e);
  }
  async mergeProvisionalElements() {
    const e = [...this.newHeadProvisionalElements];
    for (const t of this.currentHeadProvisionalElements)
      this.isCurrentElementInElementList(t, e) || document.head.removeChild(t);
    for (const t of e) document.head.appendChild(t);
  }
  isCurrentElementInElementList(e, t) {
    for (const [r, s] of t.entries()) {
      if (e.tagName == "TITLE") {
        if (s.tagName != "TITLE") continue;
        if (e.innerHTML == s.innerHTML) {
          t.splice(r, 1);
          return true;
        }
      }
      if (s.isEqualNode(e)) {
        t.splice(r, 1);
        return true;
      }
    }
    return false;
  }
  removeCurrentHeadProvisionalElements() {
    for (const e of this.currentHeadProvisionalElements)
      document.head.removeChild(e);
  }
  copyNewHeadProvisionalElements() {
    for (const e of this.newHeadProvisionalElements)
      document.head.appendChild(e);
  }
  activateNewBody() {
    document.adoptNode(this.newElement);
    this.activateNewBodyScriptElements();
  }
  activateNewBodyScriptElements() {
    for (const e of this.newBodyScriptElements) {
      const t = activateScriptElement(e);
      e.replaceWith(t);
    }
  }
  async assignNewBody() {
    await this.renderElement(this.currentElement, this.newElement);
  }
  get unusedDynamicStylesheetElements() {
    return this.oldHeadStylesheetElements.filter(
      (e) => e.getAttribute("data-turbo-track") === "dynamic",
    );
  }
  get oldHeadStylesheetElements() {
    return this.currentHeadSnapshot.getStylesheetElementsNotInSnapshot(
      this.newHeadSnapshot,
    );
  }
  get newHeadStylesheetElements() {
    return this.newHeadSnapshot.getStylesheetElementsNotInSnapshot(
      this.currentHeadSnapshot,
    );
  }
  get newHeadScriptElements() {
    return this.newHeadSnapshot.getScriptElementsNotInSnapshot(
      this.currentHeadSnapshot,
    );
  }
  get currentHeadProvisionalElements() {
    return this.currentHeadSnapshot.provisionalElements;
  }
  get newHeadProvisionalElements() {
    return this.newHeadSnapshot.provisionalElements;
  }
  get newBodyScriptElements() {
    return this.newElement.querySelectorAll("script");
  }
}
class MorphingPageRenderer extends PageRenderer {
  static renderElement(e, t) {
    morphElements(e, t, {
      callbacks: { beforeNodeMorphed: (e) => !canRefreshFrame(e) },
    });
    for (const t of e.querySelectorAll("turbo-frame"))
      canRefreshFrame(t) && refreshFrame(t);
    dispatch("turbo:morph", { detail: { currentElement: e, newElement: t } });
  }
  async preservingPermanentElements(e) {
    return await e();
  }
  get renderMethod() {
    return "morph";
  }
  get shouldAutofocus() {
    return false;
  }
}
function canRefreshFrame(e) {
  return (
    e instanceof FrameElement &&
    e.src &&
    e.refresh === "morph" &&
    !e.closest("[data-turbo-permanent]")
  );
}
function refreshFrame(e) {
  e.addEventListener(
    "turbo:before-frame-render",
    ({ detail: e }) => {
      e.render = MorphingFrameRenderer.renderElement;
    },
    { once: true },
  );
  e.reload();
}
class SnapshotCache {
  keys = [];
  snapshots = {};
  constructor(e) {
    this.size = e;
  }
  has(e) {
    return toCacheKey(e) in this.snapshots;
  }
  get(e) {
    if (this.has(e)) {
      const t = this.read(e);
      this.touch(e);
      return t;
    }
  }
  put(e, t) {
    this.write(e, t);
    this.touch(e);
    return t;
  }
  clear() {
    this.snapshots = {};
  }
  read(e) {
    return this.snapshots[toCacheKey(e)];
  }
  write(e, t) {
    this.snapshots[toCacheKey(e)] = t;
  }
  touch(e) {
    const t = toCacheKey(e);
    const r = this.keys.indexOf(t);
    r > -1 && this.keys.splice(r, 1);
    this.keys.unshift(t);
    this.trim();
  }
  trim() {
    for (const e of this.keys.splice(this.size)) delete this.snapshots[e];
  }
}
class PageView extends View {
  snapshotCache = new SnapshotCache(10);
  lastRenderedLocation = new URL(location.href);
  forceReloaded = false;
  shouldTransitionTo(e) {
    return this.snapshot.prefersViewTransitions && e.prefersViewTransitions;
  }
  renderPage(e, t = false, r = true, s) {
    const i = this.isPageRefresh(s) && this.snapshot.shouldMorphPage;
    const n = i ? MorphingPageRenderer : PageRenderer;
    const o = new n(this.snapshot, e, n.renderElement, t, r);
    o.shouldRender ? s?.changeHistory() : (this.forceReloaded = true);
    return this.render(o);
  }
  renderError(e, t) {
    t?.changeHistory();
    const r = new ErrorRenderer(
      this.snapshot,
      e,
      ErrorRenderer.renderElement,
      false,
    );
    return this.render(r);
  }
  clearSnapshotCache() {
    this.snapshotCache.clear();
  }
  async cacheSnapshot(e = this.snapshot) {
    if (e.isCacheable) {
      this.delegate.viewWillCacheSnapshot();
      const { lastRenderedLocation: t } = this;
      await nextEventLoopTick();
      const r = e.clone();
      this.snapshotCache.put(t, r);
      return r;
    }
  }
  getCachedSnapshotForLocation(e) {
    return this.snapshotCache.get(e);
  }
  isPageRefresh(e) {
    return (
      !e ||
      (this.lastRenderedLocation.pathname === e.location.pathname &&
        e.action === "replace")
    );
  }
  shouldPreserveScrollPosition(e) {
    return this.isPageRefresh(e) && this.snapshot.shouldPreserveScrollPosition;
  }
  get snapshot() {
    return PageSnapshot.fromElement(this.element);
  }
}
class Preloader {
  selector = "a[data-turbo-preload]";
  constructor(e, t) {
    this.delegate = e;
    this.snapshotCache = t;
  }
  start() {
    document.readyState === "loading"
      ? document.addEventListener("DOMContentLoaded", this.#C)
      : this.preloadOnLoadLinksForView(document.body);
  }
  stop() {
    document.removeEventListener("DOMContentLoaded", this.#C);
  }
  preloadOnLoadLinksForView(e) {
    for (const t of e.querySelectorAll(this.selector))
      this.delegate.shouldPreloadLink(t) && this.preloadURL(t);
  }
  async preloadURL(e) {
    const t = new URL(e.href);
    if (this.snapshotCache.has(t)) return;
    const r = new FetchRequest(this, i.get, t, new URLSearchParams(), e);
    await r.perform();
  }
  prepareRequest(e) {
    e.headers["X-Sec-Purpose"] = "prefetch";
  }
  async requestSucceededWithResponse(e, t) {
    try {
      const r = await t.responseHTML;
      const s = PageSnapshot.fromHTMLString(r);
      this.snapshotCache.put(e.url, s);
    } catch (e) {}
  }
  requestStarted(e) {}
  requestErrored(e) {}
  requestFinished(e) {}
  requestPreventedHandlingResponse(e, t) {}
  requestFailedWithResponse(e, t) {}
  #C = () => {
    this.preloadOnLoadLinksForView(document.body);
  };
}
class Cache {
  constructor(e) {
    this.session = e;
  }
  clear() {
    this.session.clearCache();
  }
  resetCacheControl() {
    this.#T("");
  }
  exemptPageFromCache() {
    this.#T("no-cache");
  }
  exemptPageFromPreview() {
    this.#T("no-preview");
  }
  #T(e) {
    setMetaContent("turbo-cache-control", e);
  }
}
class Session {
  navigator = new Navigator(this);
  history = new History(this);
  view = new PageView(this, document.documentElement);
  adapter = new BrowserAdapter(this);
  pageObserver = new PageObserver(this);
  cacheObserver = new CacheObserver();
  linkPrefetchObserver = new LinkPrefetchObserver(this, document);
  linkClickObserver = new LinkClickObserver(this, window);
  formSubmitObserver = new FormSubmitObserver(this, document);
  scrollObserver = new ScrollObserver(this);
  streamObserver = new StreamObserver(this);
  formLinkClickObserver = new FormLinkClickObserver(
    this,
    document.documentElement,
  );
  frameRedirector = new FrameRedirector(this, document.documentElement);
  streamMessageRenderer = new StreamMessageRenderer();
  cache = new Cache(this);
  drive = true;
  enabled = true;
  progressBarDelay = 500;
  started = false;
  formMode = "on";
  #P = 150;
  constructor(e) {
    this.recentRequests = e;
    this.preloader = new Preloader(this, this.view.snapshotCache);
    this.debouncedRefresh = this.refresh;
    this.pageRefreshDebouncePeriod = this.pageRefreshDebouncePeriod;
  }
  start() {
    if (!this.started) {
      this.pageObserver.start();
      this.cacheObserver.start();
      this.linkPrefetchObserver.start();
      this.formLinkClickObserver.start();
      this.linkClickObserver.start();
      this.formSubmitObserver.start();
      this.scrollObserver.start();
      this.streamObserver.start();
      this.frameRedirector.start();
      this.history.start();
      this.preloader.start();
      this.started = true;
      this.enabled = true;
    }
  }
  disable() {
    this.enabled = false;
  }
  stop() {
    if (this.started) {
      this.pageObserver.stop();
      this.cacheObserver.stop();
      this.linkPrefetchObserver.stop();
      this.formLinkClickObserver.stop();
      this.linkClickObserver.stop();
      this.formSubmitObserver.stop();
      this.scrollObserver.stop();
      this.streamObserver.stop();
      this.frameRedirector.stop();
      this.history.stop();
      this.preloader.stop();
      this.started = false;
    }
  }
  registerAdapter(e) {
    this.adapter = e;
  }
  visit(e, t = {}) {
    const r = t.frame ? document.getElementById(t.frame) : null;
    if (r instanceof FrameElement) {
      const s = t.action || getVisitAction(r);
      r.delegate.proposeVisitIfNavigatedWithAction(r, s);
      r.src = e.toString();
    } else this.navigator.proposeVisit(expandURL(e), t);
  }
  refresh(e, t) {
    const r = t && this.recentRequests.has(t);
    r ||
      this.navigator.currentVisit ||
      this.visit(e, { action: "replace", shouldCacheSnapshot: false });
  }
  connectStreamSource(e) {
    this.streamObserver.connectStreamSource(e);
  }
  disconnectStreamSource(e) {
    this.streamObserver.disconnectStreamSource(e);
  }
  renderStreamMessage(e) {
    this.streamMessageRenderer.render(StreamMessage.wrap(e));
  }
  clearCache() {
    this.view.clearSnapshotCache();
  }
  setProgressBarDelay(e) {
    this.progressBarDelay = e;
  }
  setFormMode(e) {
    this.formMode = e;
  }
  get location() {
    return this.history.location;
  }
  get restorationIdentifier() {
    return this.history.restorationIdentifier;
  }
  get pageRefreshDebouncePeriod() {
    return this.#P;
  }
  set pageRefreshDebouncePeriod(e) {
    this.refresh = debounce(this.debouncedRefresh.bind(this), e);
    this.#P = e;
  }
  shouldPreloadLink(e) {
    const t = e.hasAttribute("data-turbo-method");
    const r = e.hasAttribute("data-turbo-stream");
    const s = e.getAttribute("data-turbo-frame");
    const i =
      s == "_top"
        ? null
        : document.getElementById(s) ||
          findClosestRecursively(e, "turbo-frame:not([disabled])");
    if (t || r || i instanceof FrameElement) return false;
    {
      const t = new URL(e.href);
      return (
        this.elementIsNavigatable(e) &&
        locationIsVisitable(t, this.snapshot.rootLocation)
      );
    }
  }
  historyPoppedToLocationWithRestorationIdentifierAndDirection(e, t, r) {
    this.enabled
      ? this.navigator.startVisit(e, t, {
          action: "restore",
          historyChanged: true,
          direction: r,
        })
      : this.adapter.pageInvalidated({ reason: "turbo_disabled" });
  }
  scrollPositionChanged(e) {
    this.history.updateRestorationData({ scrollPosition: e });
  }
  willSubmitFormLinkToLocation(e, t) {
    return (
      this.elementIsNavigatable(e) &&
      locationIsVisitable(t, this.snapshot.rootLocation)
    );
  }
  submittedFormLinkToLocation() {}
  canPrefetchRequestToLocation(e, t) {
    return (
      this.elementIsNavigatable(e) &&
      locationIsVisitable(t, this.snapshot.rootLocation)
    );
  }
  willFollowLinkToLocation(e, t, r) {
    return (
      this.elementIsNavigatable(e) &&
      locationIsVisitable(t, this.snapshot.rootLocation) &&
      this.applicationAllowsFollowingLinkToLocation(e, t, r)
    );
  }
  followedLinkToLocation(e, t) {
    const r = this.getActionForLink(e);
    const s = e.hasAttribute("data-turbo-stream");
    this.visit(t.href, { action: r, acceptsStreamResponse: s });
  }
  allowsVisitingLocationWithAction(e, t) {
    return (
      this.locationWithActionIsSamePage(e, t) ||
      this.applicationAllowsVisitingLocation(e)
    );
  }
  visitProposedToLocation(e, t) {
    extendURLWithDeprecatedProperties(e);
    this.adapter.visitProposedToLocation(e, t);
  }
  visitStarted(e) {
    if (!e.acceptsStreamResponse) {
      markAsBusy(document.documentElement);
      this.view.markVisitDirection(e.direction);
    }
    extendURLWithDeprecatedProperties(e.location);
    e.silent ||
      this.notifyApplicationAfterVisitingLocation(e.location, e.action);
  }
  visitCompleted(e) {
    this.view.unmarkVisitDirection();
    clearBusyState(document.documentElement);
    this.notifyApplicationAfterPageLoad(e.getTimingMetrics());
  }
  locationWithActionIsSamePage(e, t) {
    return this.navigator.locationWithActionIsSamePage(e, t);
  }
  visitScrolledToSamePageLocation(e, t) {
    this.notifyApplicationAfterVisitingSamePageLocation(e, t);
  }
  willSubmitForm(e, t) {
    const r = getAction$1(e, t);
    return (
      this.submissionIsNavigatable(e, t) &&
      locationIsVisitable(expandURL(r), this.snapshot.rootLocation)
    );
  }
  formSubmitted(e, t) {
    this.navigator.submitForm(e, t);
  }
  pageBecameInteractive() {
    this.view.lastRenderedLocation = this.location;
    this.notifyApplicationAfterPageLoad();
  }
  pageLoaded() {
    this.history.assumeControlOfScrollRestoration();
  }
  pageWillUnload() {
    this.history.relinquishControlOfScrollRestoration();
  }
  receivedMessageFromStream(e) {
    this.renderStreamMessage(e);
  }
  viewWillCacheSnapshot() {
    this.navigator.currentVisit?.silent ||
      this.notifyApplicationBeforeCachingSnapshot();
  }
  allowsImmediateRender({ element: e }, t) {
    const r = this.notifyApplicationBeforeRender(e, t);
    const {
      defaultPrevented: s,
      detail: { render: i },
    } = r;
    this.view.renderer && i && (this.view.renderer.renderElement = i);
    return !s;
  }
  viewRenderedSnapshot(e, t, r) {
    this.view.lastRenderedLocation = this.history.location;
    this.notifyApplicationAfterRender(r);
  }
  preloadOnLoadLinksForView(e) {
    this.preloader.preloadOnLoadLinksForView(e);
  }
  viewInvalidated(e) {
    this.adapter.pageInvalidated(e);
  }
  frameLoaded(e) {
    this.notifyApplicationAfterFrameLoad(e);
  }
  frameRendered(e, t) {
    this.notifyApplicationAfterFrameRender(e, t);
  }
  applicationAllowsFollowingLinkToLocation(e, t, r) {
    const s = this.notifyApplicationAfterClickingLinkToLocation(e, t, r);
    return !s.defaultPrevented;
  }
  applicationAllowsVisitingLocation(e) {
    const t = this.notifyApplicationBeforeVisitingLocation(e);
    return !t.defaultPrevented;
  }
  notifyApplicationAfterClickingLinkToLocation(e, t, r) {
    return dispatch("turbo:click", {
      target: e,
      detail: { url: t.href, originalEvent: r },
      cancelable: true,
    });
  }
  notifyApplicationBeforeVisitingLocation(e) {
    return dispatch("turbo:before-visit", {
      detail: { url: e.href },
      cancelable: true,
    });
  }
  notifyApplicationAfterVisitingLocation(e, t) {
    return dispatch("turbo:visit", { detail: { url: e.href, action: t } });
  }
  notifyApplicationBeforeCachingSnapshot() {
    return dispatch("turbo:before-cache");
  }
  notifyApplicationBeforeRender(e, t) {
    return dispatch("turbo:before-render", {
      detail: { newBody: e, ...t },
      cancelable: true,
    });
  }
  notifyApplicationAfterRender(e) {
    return dispatch("turbo:render", { detail: { renderMethod: e } });
  }
  notifyApplicationAfterPageLoad(e = {}) {
    return dispatch("turbo:load", {
      detail: { url: this.location.href, timing: e },
    });
  }
  notifyApplicationAfterVisitingSamePageLocation(e, t) {
    dispatchEvent(
      new HashChangeEvent("hashchange", {
        oldURL: e.toString(),
        newURL: t.toString(),
      }),
    );
  }
  notifyApplicationAfterFrameLoad(e) {
    return dispatch("turbo:frame-load", { target: e });
  }
  notifyApplicationAfterFrameRender(e, t) {
    return dispatch("turbo:frame-render", {
      detail: { fetchResponse: e },
      target: t,
      cancelable: true,
    });
  }
  submissionIsNavigatable(e, t) {
    if (this.formMode == "off") return false;
    {
      const r = !t || this.elementIsNavigatable(t);
      return this.formMode == "optin"
        ? r && e.closest('[data-turbo="true"]') != null
        : r && this.elementIsNavigatable(e);
    }
  }
  elementIsNavigatable(e) {
    const t = findClosestRecursively(e, "[data-turbo]");
    const r = findClosestRecursively(e, "turbo-frame");
    return this.drive || r
      ? !t || t.getAttribute("data-turbo") != "false"
      : !!t && t.getAttribute("data-turbo") == "true";
  }
  getActionForLink(e) {
    return getVisitAction(e) || "advance";
  }
  get snapshot() {
    return this.view.snapshot;
  }
}
function extendURLWithDeprecatedProperties(e) {
  Object.defineProperties(e, b);
}
const b = {
  absoluteURL: {
    get() {
      return this.toString();
    },
  },
};
const v = new Session(r);
const { cache: S, navigator: E } = v;
function start() {
  v.start();
}
/**
 * Registers an adapter for the main session.
 *
 * @param adapter Adapter to register
 */ function registerAdapter(e) {
  v.registerAdapter(e);
}
/**
 * Performs an application visit to the given location.
 *
 * @param location Location to visit (a URL or path)
 * @param options Options to apply
 * @param options.action Type of history navigation to apply ("restore",
 * "replace" or "advance")
 * @param options.historyChanged Specifies whether the browser history has
 * already been changed for this visit or not
 * @param options.referrer Specifies the referrer of this visit such that
 * navigations to the same page will not result in a new history entry.
 * @param options.snapshotHTML Cached snapshot to render
 * @param options.response Response of the specified location
 */ function visit(e, t) {
  v.visit(e, t);
}
/**
 * Connects a stream source to the main session.
 *
 * @param source Stream source to connect
 */ function connectStreamSource(e) {
  v.connectStreamSource(e);
}
/**
 * Disconnects a stream source from the main session.
 *
 * @param source Stream source to disconnect
 */ function disconnectStreamSource(e) {
  v.disconnectStreamSource(e);
}
/**
 * Renders a stream message to the main session by appending it to the
 * current document.
 *
 * @param message Message to render
 */ function renderStreamMessage(e) {
  v.renderStreamMessage(e);
}
/**
 * Removes all entries from the Turbo Drive page cache.
 * Call this when state has changed on the server that may affect cached pages.
 *
 * @deprecated since version 7.2.0 in favor of `Turbo.cache.clear()`
 */ function clearCache() {
  console.warn(
    "Please replace `Turbo.clearCache()` with `Turbo.cache.clear()`. The top-level function is deprecated and will be removed in a future version of Turbo.`",
  );
  v.clearCache();
}
/**
 * Sets the delay after which the progress bar will appear during navigation.
 *
 * The progress bar appears after 500ms by default.
 *
 * Note that this method has no effect when used with the iOS or Android
 * adapters.
 *
 * @param delay Time to delay in milliseconds
 */ function setProgressBarDelay(e) {
  v.setProgressBarDelay(e);
}
function setConfirmMethod(e) {
  FormSubmission.confirmMethod = e;
}
function setFormMode(e) {
  v.setFormMode(e);
}
var w = Object.freeze({
  __proto__: null,
  navigator: E,
  session: v,
  cache: S,
  PageRenderer: PageRenderer,
  PageSnapshot: PageSnapshot,
  FrameRenderer: FrameRenderer,
  fetch: fetchWithTurboHeaders,
  start: start,
  registerAdapter: registerAdapter,
  visit: visit,
  connectStreamSource: connectStreamSource,
  disconnectStreamSource: disconnectStreamSource,
  renderStreamMessage: renderStreamMessage,
  clearCache: clearCache,
  setProgressBarDelay: setProgressBarDelay,
  setConfirmMethod: setConfirmMethod,
  setFormMode: setFormMode,
});
class TurboFrameMissingError extends Error {}
class FrameController {
  fetchResponseLoaded = (e) => Promise.resolve();
  #F = null;
  #M = () => {};
  #k = false;
  #I = false;
  #q = new Set();
  action = null;
  constructor(e) {
    this.element = e;
    this.view = new FrameView(this, this.element);
    this.appearanceObserver = new AppearanceObserver(this, this.element);
    this.formLinkClickObserver = new FormLinkClickObserver(this, this.element);
    this.linkInterceptor = new LinkInterceptor(this, this.element);
    this.restorationIdentifier = uuid();
    this.formSubmitObserver = new FormSubmitObserver(this, this.element);
  }
  connect() {
    if (!this.#k) {
      this.#k = true;
      this.loadingStyle == t.lazy ? this.appearanceObserver.start() : this.#H();
      this.formLinkClickObserver.start();
      this.linkInterceptor.start();
      this.formSubmitObserver.start();
    }
  }
  disconnect() {
    if (this.#k) {
      this.#k = false;
      this.appearanceObserver.stop();
      this.formLinkClickObserver.stop();
      this.linkInterceptor.stop();
      this.formSubmitObserver.stop();
    }
  }
  disabledChanged() {
    this.loadingStyle == t.eager && this.#H();
  }
  sourceURLChanged() {
    if (!this.#B("src")) {
      this.element.isConnected && (this.complete = false);
      (this.loadingStyle == t.eager || this.#I) && this.#H();
    }
  }
  sourceURLReloaded() {
    const { src: e } = this.element;
    this.element.removeAttribute("complete");
    this.element.src = null;
    this.element.src = e;
    return this.element.loaded;
  }
  loadingStyleChanged() {
    if (this.loadingStyle == t.lazy) this.appearanceObserver.start();
    else {
      this.appearanceObserver.stop();
      this.#H();
    }
  }
  async #H() {
    if (this.enabled && this.isActive && !this.complete && this.sourceURL) {
      this.element.loaded = this.#N(expandURL(this.sourceURL));
      this.appearanceObserver.stop();
      await this.element.loaded;
      this.#I = true;
    }
  }
  async loadResponse(e) {
    (e.redirected || (e.succeeded && e.isHTML)) &&
      (this.sourceURL = e.response.url);
    try {
      const t = await e.responseHTML;
      if (t) {
        const r = parseHTMLDocument(t);
        const s = PageSnapshot.fromDocument(r);
        s.isVisitable ? await this.#O(e, r) : await this.#x(e);
      }
    } finally {
      this.fetchResponseLoaded = () => Promise.resolve();
    }
  }
  elementAppearedInViewport(e) {
    this.proposeVisitIfNavigatedWithAction(e, getVisitAction(e));
    this.#H();
  }
  willSubmitFormLinkToLocation(e) {
    return this.#V(e);
  }
  submittedFormLinkToLocation(e, t, r) {
    const s = this.#d(e);
    s && r.setAttribute("data-turbo-frame", s.id);
  }
  shouldInterceptLinkClick(e, t, r) {
    return this.#V(e);
  }
  linkClickIntercepted(e, t) {
    this.#D(e, t);
  }
  willSubmitForm(e, t) {
    return e.closest("turbo-frame") == this.element && this.#V(e, t);
  }
  formSubmitted(e, t) {
    this.formSubmission && this.formSubmission.stop();
    this.formSubmission = new FormSubmission(this, e, t);
    const { fetchRequest: r } = this.formSubmission;
    this.prepareRequest(r);
    this.formSubmission.start();
  }
  prepareRequest(e) {
    e.headers["Turbo-Frame"] = this.id;
    this.currentNavigationElement?.hasAttribute("data-turbo-stream") &&
      e.acceptResponseType(StreamMessage.contentType);
  }
  requestStarted(e) {
    markAsBusy(this.element);
  }
  requestPreventedHandlingResponse(e, t) {
    this.#M();
  }
  async requestSucceededWithResponse(e, t) {
    await this.loadResponse(t);
    this.#M();
  }
  async requestFailedWithResponse(e, t) {
    await this.loadResponse(t);
    this.#M();
  }
  requestErrored(e, t) {
    console.error(t);
    this.#M();
  }
  requestFinished(e) {
    clearBusyState(this.element);
  }
  formSubmissionStarted({ formElement: e }) {
    markAsBusy(e, this.#d(e));
  }
  formSubmissionSucceededWithResponse(e, t) {
    const r = this.#d(e.formElement, e.submitter);
    r.delegate.proposeVisitIfNavigatedWithAction(
      r,
      getVisitAction(e.submitter, e.formElement, r),
    );
    r.delegate.loadResponse(t);
    e.isSafe || v.clearCache();
  }
  formSubmissionFailedWithResponse(e, t) {
    this.element.delegate.loadResponse(t);
    v.clearCache();
  }
  formSubmissionErrored(e, t) {
    console.error(t);
  }
  formSubmissionFinished({ formElement: e }) {
    clearBusyState(e, this.#d(e));
  }
  allowsImmediateRender({ element: e }, t) {
    const r = dispatch("turbo:before-frame-render", {
      target: this.element,
      detail: { newFrame: e, ...t },
      cancelable: true,
    });
    const {
      defaultPrevented: s,
      detail: { render: i },
    } = r;
    this.view.renderer && i && (this.view.renderer.renderElement = i);
    return !s;
  }
  viewRenderedSnapshot(e, t, r) {}
  preloadOnLoadLinksForView(e) {
    v.preloadOnLoadLinksForView(e);
  }
  viewInvalidated() {}
  willRenderFrame(e, t) {
    this.previousFrameElement = e.cloneNode(true);
  }
  visitCachedSnapshot = ({ element: e }) => {
    const t = e.querySelector("#" + this.element.id);
    t &&
      this.previousFrameElement &&
      t.replaceChildren(...this.previousFrameElement.children);
    delete this.previousFrameElement;
  };
  async #O(e, t) {
    const r = await this.extractForeignFrameElement(t.body);
    if (r) {
      const t = new Snapshot(r);
      const s = new FrameRenderer(
        this,
        this.view.snapshot,
        t,
        FrameRenderer.renderElement,
        false,
        false,
      );
      this.view.renderPromise && (await this.view.renderPromise);
      this.changeHistory();
      await this.view.render(s);
      this.complete = true;
      v.frameRendered(e, this.element);
      v.frameLoaded(this.element);
      await this.fetchResponseLoaded(e);
    } else this.#W(e) && this.#U(e);
  }
  async #N(e) {
    const t = new FetchRequest(
      this,
      i.get,
      e,
      new URLSearchParams(),
      this.element,
    );
    this.#F?.cancel();
    this.#F = t;
    return new Promise((e) => {
      this.#M = () => {
        this.#M = () => {};
        this.#F = null;
        e();
      };
      t.perform();
    });
  }
  #D(e, t, r) {
    const s = this.#d(e, r);
    s.delegate.proposeVisitIfNavigatedWithAction(s, getVisitAction(r, e, s));
    this.#$(e, () => {
      s.src = t;
    });
  }
  proposeVisitIfNavigatedWithAction(e, t = null) {
    this.action = t;
    if (this.action) {
      const t = PageSnapshot.fromElement(e).clone();
      const { visitCachedSnapshot: r } = e.delegate;
      e.delegate.fetchResponseLoaded = async (s) => {
        if (e.src) {
          const { statusCode: i, redirected: n } = s;
          const o = await s.responseHTML;
          const a = { statusCode: i, redirected: n, responseHTML: o };
          const c = {
            response: a,
            visitCachedSnapshot: r,
            willRender: false,
            updateHistory: false,
            restorationIdentifier: this.restorationIdentifier,
            snapshot: t,
          };
          this.action && (c.action = this.action);
          v.visit(e.src, c);
        }
      };
    }
  }
  changeHistory() {
    if (this.action) {
      const e = getHistoryMethodForAction(this.action);
      v.history.update(
        e,
        expandURL(this.element.src || ""),
        this.restorationIdentifier,
      );
    }
  }
  async #x(e) {
    console.warn(
      `The response (${e.statusCode}) from <turbo-frame id="${this.element.id}"> is performing a full page visit due to turbo-visit-control.`,
    );
    await this.#z(e.response);
  }
  #W(e) {
    this.element.setAttribute("complete", "");
    const t = e.response;
    const visit = async (e, t) => {
      e instanceof Response ? this.#z(e) : v.visit(e, t);
    };
    const r = dispatch("turbo:frame-missing", {
      target: this.element,
      detail: { response: t, visit: visit },
      cancelable: true,
    });
    return !r.defaultPrevented;
  }
  #U(e) {
    this.view.missing();
    this.#j(e);
  }
  #j(e) {
    const t = `The response (${e.statusCode}) did not contain the expected <turbo-frame id="${this.element.id}"> and will be ignored. To perform a full page visit instead, set turbo-visit-control to reload.`;
    throw new TurboFrameMissingError(t);
  }
  async #z(e) {
    const t = new FetchResponse(e);
    const r = await t.responseHTML;
    const { location: s, redirected: i, statusCode: n } = t;
    return v.visit(s, {
      response: { redirected: i, statusCode: n, responseHTML: r },
    });
  }
  #d(e, t) {
    const r =
      getAttribute("data-turbo-frame", t, e) ||
      this.element.getAttribute("target");
    return getFrameElementById(r) ?? this.element;
  }
  async extractForeignFrameElement(e) {
    let t;
    const r = CSS.escape(this.id);
    try {
      t = activateElement(e.querySelector(`turbo-frame#${r}`), this.sourceURL);
      if (t) return t;
      t = activateElement(
        e.querySelector(`turbo-frame[src][recurse~=${r}]`),
        this.sourceURL,
      );
      if (t) {
        await t.loaded;
        return await this.extractForeignFrameElement(t);
      }
    } catch (e) {
      console.error(e);
      return new FrameElement();
    }
    return null;
  }
  #_(e, t) {
    const r = getAction$1(e, t);
    return locationIsVisitable(expandURL(r), this.rootLocation);
  }
  #V(e, t) {
    const r =
      getAttribute("data-turbo-frame", t, e) ||
      this.element.getAttribute("target");
    if (e instanceof HTMLFormElement && !this.#_(e, t)) return false;
    if (!this.enabled || r == "_top") return false;
    if (r) {
      const e = getFrameElementById(r);
      if (e) return !e.disabled;
    }
    return !!v.elementIsNavigatable(e) && !(t && !v.elementIsNavigatable(t));
  }
  get id() {
    return this.element.id;
  }
  get enabled() {
    return !this.element.disabled;
  }
  get sourceURL() {
    if (this.element.src) return this.element.src;
  }
  set sourceURL(e) {
    this.#K("src", () => {
      this.element.src = e ?? null;
    });
  }
  get loadingStyle() {
    return this.element.loading;
  }
  get isLoading() {
    return this.formSubmission !== void 0 || this.#M() !== void 0;
  }
  get complete() {
    return this.element.hasAttribute("complete");
  }
  set complete(e) {
    e
      ? this.element.setAttribute("complete", "")
      : this.element.removeAttribute("complete");
  }
  get isActive() {
    return this.element.isActive && this.#k;
  }
  get rootLocation() {
    const e = this.element.ownerDocument.querySelector(
      'meta[name="turbo-root"]',
    );
    const t = e?.content ?? "/";
    return expandURL(t);
  }
  #B(e) {
    return this.#q.has(e);
  }
  #K(e, t) {
    this.#q.add(e);
    t();
    this.#q.delete(e);
  }
  #$(e, t) {
    this.currentNavigationElement = e;
    t();
    delete this.currentNavigationElement;
  }
}
function getFrameElementById(e) {
  if (e != null) {
    const t = document.getElementById(e);
    if (t instanceof FrameElement) return t;
  }
}
function activateElement(e, t) {
  if (e) {
    const r = e.getAttribute("src");
    if (r != null && t != null && urlsAreEqual(r, t))
      throw new Error(
        `Matching <turbo-frame id="${e.id}"> element has a source URL which references itself`,
      );
    e.ownerDocument !== document && (e = document.importNode(e, true));
    if (e instanceof FrameElement) {
      e.connectedCallback();
      e.disconnectedCallback();
      return e;
    }
  }
}
const y = {
  after() {
    this.targetElements.forEach((e) =>
      e.parentElement?.insertBefore(this.templateContent, e.nextSibling),
    );
  },
  append() {
    this.removeDuplicateTargetChildren();
    this.targetElements.forEach((e) => e.append(this.templateContent));
  },
  before() {
    this.targetElements.forEach((e) =>
      e.parentElement?.insertBefore(this.templateContent, e),
    );
  },
  prepend() {
    this.removeDuplicateTargetChildren();
    this.targetElements.forEach((e) => e.prepend(this.templateContent));
  },
  remove() {
    this.targetElements.forEach((e) => e.remove());
  },
  replace() {
    const e = this.getAttribute("method");
    this.targetElements.forEach((t) => {
      e === "morph"
        ? morphElements(t, this.templateContent)
        : t.replaceWith(this.templateContent);
    });
  },
  update() {
    const e = this.getAttribute("method");
    this.targetElements.forEach((t) => {
      if (e === "morph") morphChildren(t, this.templateContent);
      else {
        t.innerHTML = "";
        t.append(this.templateContent);
      }
    });
  },
  refresh() {
    v.refresh(this.baseURI, this.requestId);
  },
};
class StreamElement extends HTMLElement {
  static async renderElement(e) {
    await e.performAction();
  }
  async connectedCallback() {
    try {
      await this.render();
    } catch (e) {
      console.error(e);
    } finally {
      this.disconnect();
    }
  }
  async render() {
    return (this.renderPromise ??= (async () => {
      const e = this.beforeRenderEvent;
      if (this.dispatchEvent(e)) {
        await nextRepaint();
        await e.detail.render(this);
      }
    })());
  }
  disconnect() {
    try {
      this.remove();
    } catch {}
  }
  removeDuplicateTargetChildren() {
    this.duplicateChildren.forEach((e) => e.remove());
  }
  get duplicateChildren() {
    const e = this.targetElements
      .flatMap((e) => [...e.children])
      .filter((e) => !!e.id);
    const t = [...(this.templateContent?.children || [])]
      .filter((e) => !!e.id)
      .map((e) => e.id);
    return e.filter((e) => t.includes(e.id));
  }
  get performAction() {
    if (this.action) {
      const e = y[this.action];
      if (e) return e;
      this.#X("unknown action");
    }
    this.#X("action attribute is missing");
  }
  get targetElements() {
    if (this.target) return this.targetElementsById;
    if (this.targets) return this.targetElementsByQuery;
    this.#X("target or targets attribute is missing");
  }
  get templateContent() {
    return this.templateElement.content.cloneNode(true);
  }
  get templateElement() {
    if (this.firstElementChild === null) {
      const e = this.ownerDocument.createElement("template");
      this.appendChild(e);
      return e;
    }
    if (this.firstElementChild instanceof HTMLTemplateElement)
      return this.firstElementChild;
    this.#X("first child element must be a <template> element");
  }
  get action() {
    return this.getAttribute("action");
  }
  get target() {
    return this.getAttribute("target");
  }
  get targets() {
    return this.getAttribute("targets");
  }
  get requestId() {
    return this.getAttribute("request-id");
  }
  #X(e) {
    throw new Error(`${this.description}: ${e}`);
  }
  get description() {
    return (this.outerHTML.match(/<[^>]+>/) ?? [])[0] ?? "<turbo-stream>";
  }
  get beforeRenderEvent() {
    return new CustomEvent("turbo:before-stream-render", {
      bubbles: true,
      cancelable: true,
      detail: { newStream: this, render: StreamElement.renderElement },
    });
  }
  get targetElementsById() {
    const e = this.ownerDocument?.getElementById(this.target);
    return e !== null ? [e] : [];
  }
  get targetElementsByQuery() {
    const e = this.ownerDocument?.querySelectorAll(this.targets);
    return e.length !== 0 ? Array.prototype.slice.call(e) : [];
  }
}
class StreamSourceElement extends HTMLElement {
  streamSource = null;
  connectedCallback() {
    this.streamSource = this.src.match(/^ws{1,2}:/)
      ? new WebSocket(this.src)
      : new EventSource(this.src);
    connectStreamSource(this.streamSource);
  }
  disconnectedCallback() {
    if (this.streamSource) {
      this.streamSource.close();
      disconnectStreamSource(this.streamSource);
    }
  }
  get src() {
    return this.getAttribute("src") || "";
  }
}
FrameElement.delegateConstructor = FrameController;
customElements.get("turbo-frame") === void 0 &&
  customElements.define("turbo-frame", FrameElement);
customElements.get("turbo-stream") === void 0 &&
  customElements.define("turbo-stream", StreamElement);
customElements.get("turbo-stream-source") === void 0 &&
  customElements.define("turbo-stream-source", StreamSourceElement);
(() => {
  let e = document.currentScript;
  if (e && !e.hasAttribute("data-turbo-suppress-warning")) {
    e = e.parentElement;
    while (e) {
      if (e == document.body)
        return console.warn(
          unindent`
        You are loading Turbo from a <script> element inside the <body> element. This is probably not what you meant to do!

        Load your application’s JavaScript bundle inside the <head> element instead. <script> elements in <body> are evaluated with each page change.

        For more information, see: https://turbo.hotwired.dev/handbook/building#working-with-script-elements

        ——
        Suppress this warning by adding a "data-turbo-suppress-warning" attribute to: %s
      `,
          e.outerHTML,
        );
      e = e.parentElement;
    }
  }
})();
window.Turbo = { ...w, StreamActions: y };
start();
export {
  n as FetchEnctype,
  i as FetchMethod,
  FetchRequest,
  FetchResponse,
  FrameElement,
  t as FrameLoadingStyle,
  FrameRenderer,
  PageRenderer,
  PageSnapshot,
  y as StreamActions,
  StreamElement,
  StreamSourceElement,
  S as cache,
  clearCache,
  connectStreamSource,
  disconnectStreamSource,
  fetchWithTurboHeaders as fetch,
  fetchEnctypeFromString,
  fetchMethodFromString,
  isSafe,
  E as navigator,
  registerAdapter,
  renderStreamMessage,
  v as session,
  setConfirmMethod,
  setFormMode,
  setProgressBarDelay,
  start,
  visit,
};
