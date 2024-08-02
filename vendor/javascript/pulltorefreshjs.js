// pulltorefreshjs@0.1.22 downloaded from https://ga.jspm.io/npm:pulltorefreshjs@0.1.22/dist/index.umd.js

var e = {};
(function (t, n) {
  e = n();
})(0, function () {
  var e = {
    pullStartY: null,
    pullMoveY: null,
    handlers: [],
    styleEl: null,
    events: null,
    dist: 0,
    state: "pending",
    timeout: null,
    distResisted: 0,
    supportsPassive: false,
    supportsPointerEvents:
      "undefined" !== typeof window && !!window.PointerEvent,
  };
  try {
    window.addEventListener("test", null, {
      get passive() {
        e.supportsPassive = true;
      },
    });
  } catch (e) {}
  function setupDOM(t) {
    if (!t.ptrElement) {
      var n = document.createElement("div");
      t.mainElement !== document.body
        ? t.mainElement.parentNode.insertBefore(n, t.mainElement)
        : document.body.insertBefore(n, document.body.firstChild);
      n.classList.add(t.classPrefix + "ptr");
      n.innerHTML = t.getMarkup().replace(/__PREFIX__/g, t.classPrefix);
      t.ptrElement = n;
      "function" === typeof t.onInit && t.onInit(t);
      if (!e.styleEl) {
        e.styleEl = document.createElement("style");
        e.styleEl.setAttribute("id", "pull-to-refresh-js-style");
        document.head.appendChild(e.styleEl);
      }
      e.styleEl.textContent = t
        .getStyles()
        .replace(/__PREFIX__/g, t.classPrefix)
        .replace(/\s+/g, " ");
    }
    return t;
  }
  function onReset(t) {
    if (t.ptrElement) {
      t.ptrElement.classList.remove(t.classPrefix + "refresh");
      t.ptrElement.style[t.cssProp] = "0px";
      setTimeout(function () {
        if (t.ptrElement && t.ptrElement.parentNode) {
          t.ptrElement.parentNode.removeChild(t.ptrElement);
          t.ptrElement = null;
        }
        e.state = "pending";
      }, t.refreshTimeout);
    }
  }
  function update(t) {
    var n = t.ptrElement.querySelector("." + t.classPrefix + "icon");
    var s = t.ptrElement.querySelector("." + t.classPrefix + "text");
    n &&
      ("refreshing" === e.state
        ? (n.innerHTML = t.iconRefreshing)
        : (n.innerHTML = t.iconArrow));
    if (s) {
      "releasing" === e.state && (s.innerHTML = t.instructionsReleaseToRefresh);
      ("pulling" !== e.state && "pending" !== e.state) ||
        (s.innerHTML = t.instructionsPullToRefresh);
      "refreshing" === e.state && (s.innerHTML = t.instructionsRefreshing);
    }
  }
  var t = { setupDOM: setupDOM, onReset: onReset, update: update };
  var n;
  var s = function screenY(t) {
    return e.pointerEventsEnabled && e.supportsPointerEvents
      ? t.screenY
      : t.touches[0].screenY;
  };
  var _setupEvents = function () {
    var r;
    function _onTouchStart(n) {
      var o = e.handlers.filter(function (e) {
        return e.contains(n.target);
      })[0];
      e.enable = !!o;
      if (o && "pending" === e.state) {
        r = t.setupDOM(o);
        o.shouldPullToRefresh() && (e.pullStartY = s(n));
        clearTimeout(e.timeout);
        t.update(o);
      }
    }
    function _onTouchMove(n) {
      if (r && r.ptrElement && e.enable) {
        e.pullStartY
          ? (e.pullMoveY = s(n))
          : r.shouldPullToRefresh() && (e.pullStartY = s(n));
        if ("refreshing" !== e.state) {
          if ("pending" === e.state) {
            r.ptrElement.classList.add(r.classPrefix + "pull");
            e.state = "pulling";
            t.update(r);
          }
          e.pullStartY && e.pullMoveY && (e.dist = e.pullMoveY - e.pullStartY);
          e.distExtra = e.dist - r.distIgnore;
          if (e.distExtra > 0) {
            n.cancelable && n.preventDefault();
            r.ptrElement.style[r.cssProp] = e.distResisted + "px";
            e.distResisted =
              r.resistanceFunction(e.distExtra / r.distThreshold) *
              Math.min(r.distMax, e.distExtra);
            if ("pulling" === e.state && e.distResisted > r.distThreshold) {
              r.ptrElement.classList.add(r.classPrefix + "release");
              e.state = "releasing";
              t.update(r);
            }
            if ("releasing" === e.state && e.distResisted < r.distThreshold) {
              r.ptrElement.classList.remove(r.classPrefix + "release");
              e.state = "pulling";
              t.update(r);
            }
          }
        } else
          n.cancelable &&
            r.shouldPullToRefresh() &&
            e.pullStartY < e.pullMoveY &&
            n.preventDefault();
      }
    }
    function _onTouchEnd() {
      if (r && r.ptrElement && e.enable) {
        clearTimeout(n);
        n = setTimeout(function () {
          r && r.ptrElement && "pending" === e.state && t.onReset(r);
        }, 500);
        if ("releasing" === e.state && e.distResisted > r.distThreshold) {
          e.state = "refreshing";
          r.ptrElement.style[r.cssProp] = r.distReload + "px";
          r.ptrElement.classList.add(r.classPrefix + "refresh");
          e.timeout = setTimeout(function () {
            var e = r.onRefresh(function () {
              return t.onReset(r);
            });
            e &&
              "function" === typeof e.then &&
              e.then(function () {
                return t.onReset(r);
              });
            e || r.onRefresh.length || t.onReset(r);
          }, r.refreshTimeout);
        } else {
          if ("refreshing" === e.state) return;
          r.ptrElement.style[r.cssProp] = "0px";
          e.state = "pending";
        }
        t.update(r);
        r.ptrElement.classList.remove(r.classPrefix + "release");
        r.ptrElement.classList.remove(r.classPrefix + "pull");
        e.pullStartY = e.pullMoveY = null;
        e.dist = e.distResisted = 0;
      }
    }
    function _onScroll() {
      r &&
        r.mainElement.classList.toggle(
          r.classPrefix + "top",
          r.shouldPullToRefresh(),
        );
    }
    var o = e.supportsPassive ? { passive: e.passive || false } : void 0;
    if (e.pointerEventsEnabled && e.supportsPointerEvents) {
      window.addEventListener("pointerup", _onTouchEnd);
      window.addEventListener("pointerdown", _onTouchStart);
      window.addEventListener("pointermove", _onTouchMove, o);
    } else {
      window.addEventListener("touchend", _onTouchEnd);
      window.addEventListener("touchstart", _onTouchStart);
      window.addEventListener("touchmove", _onTouchMove, o);
    }
    window.addEventListener("scroll", _onScroll);
    return {
      onTouchEnd: _onTouchEnd,
      onTouchStart: _onTouchStart,
      onTouchMove: _onTouchMove,
      onScroll: _onScroll,
      destroy: function destroy() {
        if (e.pointerEventsEnabled && e.supportsPointerEvents) {
          window.removeEventListener("pointerdown", _onTouchStart);
          window.removeEventListener("pointerup", _onTouchEnd);
          window.removeEventListener("pointermove", _onTouchMove, o);
        } else {
          window.removeEventListener("touchstart", _onTouchStart);
          window.removeEventListener("touchend", _onTouchEnd);
          window.removeEventListener("touchmove", _onTouchMove, o);
        }
        window.removeEventListener("scroll", _onScroll);
      },
    };
  };
  var r =
    '\n<div class="__PREFIX__box">\n  <div class="__PREFIX__content">\n    <div class="__PREFIX__icon"></div>\n    <div class="__PREFIX__text"></div>\n  </div>\n</div>\n';
  var o =
    "\n.__PREFIX__ptr {\n  box-shadow: inset 0 -3px 5px rgba(0, 0, 0, 0.12);\n  pointer-events: none;\n  font-size: 0.85em;\n  font-weight: bold;\n  top: 0;\n  height: 0;\n  transition: height 0.3s, min-height 0.3s;\n  text-align: center;\n  width: 100%;\n  overflow: hidden;\n  display: flex;\n  align-items: flex-end;\n  align-content: stretch;\n}\n\n.__PREFIX__box {\n  padding: 10px;\n  flex-basis: 100%;\n}\n\n.__PREFIX__pull {\n  transition: none;\n}\n\n.__PREFIX__text {\n  margin-top: .33em;\n  color: rgba(0, 0, 0, 0.3);\n}\n\n.__PREFIX__icon {\n  color: rgba(0, 0, 0, 0.3);\n  transition: transform .3s;\n}\n\n/*\nWhen at the top of the page, disable vertical overscroll so passive touch\nlisteners can take over.\n*/\n.__PREFIX__top {\n  touch-action: pan-x pan-down pinch-zoom;\n}\n\n.__PREFIX__release .__PREFIX__icon {\n  transform: rotate(180deg);\n}\n";
  var i = {
    distThreshold: 60,
    distMax: 80,
    distReload: 50,
    distIgnore: 0,
    mainElement: "body",
    triggerElement: "body",
    ptrElement: ".ptr",
    classPrefix: "ptr--",
    cssProp: "min-height",
    iconArrow: "&#8675;",
    iconRefreshing: "&hellip;",
    instructionsPullToRefresh: "Pull down to refresh",
    instructionsReleaseToRefresh: "Release to refresh",
    instructionsRefreshing: "Refreshing",
    refreshTimeout: 500,
    getMarkup: function () {
      return r;
    },
    getStyles: function () {
      return o;
    },
    onInit: function () {},
    onRefresh: function () {
      return location.reload();
    },
    resistanceFunction: function (e) {
      return Math.min(1, e / 2.5);
    },
    shouldPullToRefresh: function () {
      return !window.scrollY;
    },
  };
  var l = ["mainElement", "ptrElement", "triggerElement"];
  var _setupHandler = function (t) {
    var n = {};
    Object.keys(i).forEach(function (e) {
      n[e] = t[e] || i[e];
    });
    n.refreshTimeout =
      "number" === typeof t.refreshTimeout
        ? t.refreshTimeout
        : i.refreshTimeout;
    l.forEach(function (e) {
      "string" === typeof n[e] && (n[e] = document.querySelector(n[e]));
    });
    e.events || (e.events = _setupEvents());
    n.contains = function (e) {
      return n.triggerElement.contains(e);
    };
    n.destroy = function () {
      clearTimeout(e.timeout);
      var t = e.handlers.indexOf(n);
      e.handlers.splice(t, 1);
    };
    return n;
  };
  var a = {
    setPassiveMode: function setPassiveMode(t) {
      e.passive = t;
    },
    setPointerEventsMode: function setPointerEventsMode(t) {
      e.pointerEventsEnabled = t;
    },
    destroyAll: function destroyAll() {
      if (e.events) {
        e.events.destroy();
        e.events = null;
      }
      e.handlers.forEach(function (e) {
        e.destroy();
      });
    },
    init: function init(t) {
      void 0 === t && (t = {});
      var n = _setupHandler(t);
      e.handlers.push(n);
      return n;
    },
    _: {
      setupHandler: _setupHandler,
      setupEvents: _setupEvents,
      setupDOM: t.setupDOM,
      onReset: t.onReset,
      update: t.update,
    },
  };
  return a;
});
var t = e;
export default t;
