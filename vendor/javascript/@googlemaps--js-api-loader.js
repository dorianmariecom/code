function __awaiter(e, t, i, r) {
  function adopt(e) {
    return e instanceof i
      ? e
      : new i(function (t) {
          t(e);
        });
  }
  return new (i || (i = Promise))(function (i, s) {
    function fulfilled(e) {
      try {
        step(r.next(e));
      } catch (e) {
        s(e);
      }
    }
    function rejected(e) {
      try {
        step(r.throw(e));
      } catch (e) {
        s(e);
      }
    }
    function step(e) {
      e.done ? i(e.value) : adopt(e.value).then(fulfilled, rejected);
    }
    step((r = r.apply(e, t || [])).next());
  });
}
var e = function equal(e, t) {
  if (e === t) return true;
  if (e && t && "object" == typeof e && "object" == typeof t) {
    if (e.constructor !== t.constructor) return false;
    var i, r, s;
    if (Array.isArray(e)) {
      i = e.length;
      if (i != t.length) return false;
      for (r = i; 0 !== r--; ) if (!equal(e[r], t[r])) return false;
      return true;
    }
    if (e.constructor === RegExp)
      return e.source === t.source && e.flags === t.flags;
    if (e.valueOf !== Object.prototype.valueOf)
      return e.valueOf() === t.valueOf();
    if (e.toString !== Object.prototype.toString)
      return e.toString() === t.toString();
    s = Object.keys(e);
    i = s.length;
    if (i !== Object.keys(t).length) return false;
    for (r = i; 0 !== r--; )
      if (!Object.prototype.hasOwnProperty.call(t, s[r])) return false;
    for (r = i; 0 !== r--; ) {
      var o = s[r];
      if (!equal(e[o], t[o])) return false;
    }
    return true;
  }
  return e !== e && t !== t;
};
const t = "__googleMapsScriptId";
var i;
(function (e) {
  e[(e.INITIALIZED = 0)] = "INITIALIZED";
  e[(e.LOADING = 1)] = "LOADING";
  e[(e.SUCCESS = 2)] = "SUCCESS";
  e[(e.FAILURE = 3)] = "FAILURE";
})(i || (i = {}));
class Loader {
  constructor({
    apiKey: i,
    authReferrerPolicy: r,
    channel: s,
    client: o,
    id: n = t,
    language: a,
    libraries: l = [],
    mapIds: h,
    nonce: c,
    region: d,
    retries: g = 3,
    url: p = "https://maps.googleapis.com/maps/api/js",
    version: f,
  }) {
    this.callbacks = [];
    this.done = false;
    this.loading = false;
    this.errors = [];
    this.apiKey = i;
    this.authReferrerPolicy = r;
    this.channel = s;
    this.client = o;
    this.id = n || t;
    this.language = a;
    this.libraries = l;
    this.mapIds = h;
    this.nonce = c;
    this.region = d;
    this.retries = g;
    this.url = p;
    this.version = f;
    if (Loader.instance) {
      if (!e(this.options, Loader.instance.options))
        throw new Error(
          `Loader must not be called again with different options. ${JSON.stringify(this.options)} !== ${JSON.stringify(Loader.instance.options)}`,
        );
      return Loader.instance;
    }
    Loader.instance = this;
  }
  get options() {
    return {
      version: this.version,
      apiKey: this.apiKey,
      channel: this.channel,
      client: this.client,
      id: this.id,
      libraries: this.libraries,
      language: this.language,
      region: this.region,
      mapIds: this.mapIds,
      nonce: this.nonce,
      url: this.url,
      authReferrerPolicy: this.authReferrerPolicy,
    };
  }
  get status() {
    return this.errors.length
      ? i.FAILURE
      : this.done
        ? i.SUCCESS
        : this.loading
          ? i.LOADING
          : i.INITIALIZED;
  }
  get failed() {
    return this.done && !this.loading && this.errors.length >= this.retries + 1;
  }
  /**
   * CreateUrl returns the Google Maps JavaScript API script url given the [[LoaderOptions]].
   *
   * @ignore
   * @deprecated
   */ createUrl() {
    let e = this.url;
    e += "?callback=__googleMapsCallback";
    this.apiKey && (e += `&key=${this.apiKey}`);
    this.channel && (e += `&channel=${this.channel}`);
    this.client && (e += `&client=${this.client}`);
    this.libraries.length > 0 &&
      (e += `&libraries=${this.libraries.join(",")}`);
    this.language && (e += `&language=${this.language}`);
    this.region && (e += `&region=${this.region}`);
    this.version && (e += `&v=${this.version}`);
    this.mapIds && (e += `&map_ids=${this.mapIds.join(",")}`);
    this.authReferrerPolicy &&
      (e += `&auth_referrer_policy=${this.authReferrerPolicy}`);
    return e;
  }
  deleteScript() {
    const e = document.getElementById(this.id);
    e && e.remove();
  }
  /**
   * Load the Google Maps JavaScript API script and return a Promise.
   * @deprecated, use importLibrary() instead.
   */ load() {
    return this.loadPromise();
  }
  /**
   * Load the Google Maps JavaScript API script and return a Promise.
   *
   * @ignore
   * @deprecated, use importLibrary() instead.
   */ loadPromise() {
    return new Promise((e, t) => {
      this.loadCallback((i) => {
        i ? t(i.error) : e(window.google);
      });
    });
  }
  importLibrary(e) {
    this.execute();
    return google.maps.importLibrary(e);
  }
  /**
   * Load the Google Maps JavaScript API script with a callback.
   * @deprecated, use importLibrary() instead.
   */ loadCallback(e) {
    this.callbacks.push(e);
    this.execute();
  }
  setScript() {
    var e, t;
    if (document.getElementById(this.id)) {
      this.callback();
      return;
    }
    const i = {
      key: this.apiKey,
      channel: this.channel,
      client: this.client,
      libraries: this.libraries.length && this.libraries,
      v: this.version,
      mapIds: this.mapIds,
      language: this.language,
      region: this.region,
      authReferrerPolicy: this.authReferrerPolicy,
    };
    Object.keys(i).forEach((e) => !i[e] && delete i[e]);
    (null ===
      (t =
        null ===
          (e = null === window || void 0 === window ? void 0 : window.google) ||
        void 0 === e
          ? void 0
          : e.maps) || void 0 === t
      ? void 0
      : t.importLibrary) ||
      ((e) => {
        let t,
          i,
          r,
          s = "The Google Maps JavaScript API",
          o = "google",
          n = "importLibrary",
          a = "__ib__",
          l = document,
          h = window;
        h = h[o] || (h[o] = {});
        const c = h.maps || (h.maps = {}),
          d = new Set(),
          g = new URLSearchParams(),
          u = () =>
            t ||
            (t = new Promise((n, h) =>
              __awaiter(this, void 0, void 0, function* () {
                var p;
                yield (i = l.createElement("script"));
                i.id = this.id;
                g.set("libraries", [...d] + "");
                for (r in e)
                  g.set(
                    r.replace(/[A-Z]/g, (e) => "_" + e[0].toLowerCase()),
                    e[r],
                  );
                g.set("callback", o + ".maps." + a);
                i.src = this.url + "?" + g;
                c[a] = n;
                i.onerror = () => (t = h(Error(s + " could not load.")));
                i.nonce =
                  this.nonce ||
                  (null === (p = l.querySelector("script[nonce]")) ||
                  void 0 === p
                    ? void 0
                    : p.nonce) ||
                  "";
                l.head.append(i);
              }),
            ));
        c[n]
          ? console.warn(s + " only loads once. Ignoring:", e)
          : (c[n] = (e, ...t) => d.add(e) && u().then(() => c[n](e, ...t)));
      })(i);
    const r = this.libraries.map((e) => this.importLibrary(e));
    r.length || r.push(this.importLibrary("core"));
    Promise.all(r).then(
      () => this.callback(),
      (e) => {
        const t = new ErrorEvent("error", { error: e });
        this.loadErrorCallback(t);
      },
    );
  }
  reset() {
    this.deleteScript();
    this.done = false;
    this.loading = false;
    this.errors = [];
    this.onerrorEvent = null;
  }
  resetIfRetryingFailed() {
    this.failed && this.reset();
  }
  loadErrorCallback(e) {
    this.errors.push(e);
    if (this.errors.length <= this.retries) {
      const e = this.errors.length * Math.pow(2, this.errors.length);
      console.error(`Failed to load Google Maps script, retrying in ${e} ms.`);
      setTimeout(() => {
        this.deleteScript();
        this.setScript();
      }, e);
    } else {
      this.onerrorEvent = e;
      this.callback();
    }
  }
  callback() {
    this.done = true;
    this.loading = false;
    this.callbacks.forEach((e) => {
      e(this.onerrorEvent);
    });
    this.callbacks = [];
  }
  execute() {
    this.resetIfRetryingFailed();
    if (this.done) this.callback();
    else {
      if (window.google && window.google.maps && window.google.maps.version) {
        console.warn(
          "Google Maps already loaded outside @googlemaps/js-api-loader.This may result in undesirable behavior as options and script parameters may not match.",
        );
        this.callback();
        return;
      }
      if (this.loading);
      else {
        this.loading = true;
        this.setScript();
      }
    }
  }
}
export { t as DEFAULT_ID, Loader, i as LoaderStatus };
