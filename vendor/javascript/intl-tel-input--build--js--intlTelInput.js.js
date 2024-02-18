var t =
  typeof globalThis !== "undefined"
    ? globalThis
    : typeof self !== "undefined"
      ? self
      : global;
var e = {};
(function (t) {
  e ? (e = t()) : (window.intlTelInput = t());
})(function (e) {
  return (function () {
    var i = [
      ["Afghanistan", "af", "93"],
      ["Albania", "al", "355"],
      ["Algeria", "dz", "213"],
      ["American Samoa", "as", "1", 5, ["684"]],
      ["Andorra", "ad", "376"],
      ["Angola", "ao", "244"],
      ["Anguilla", "ai", "1", 6, ["264"]],
      ["Antigua & Barbuda", "ag", "1", 7, ["268"]],
      ["Argentina", "ar", "54"],
      ["Armenia", "am", "374"],
      ["Aruba", "aw", "297"],
      ["Ascension Island", "ac", "247"],
      ["Australia", "au", "61", 0],
      ["Austria", "at", "43"],
      ["Azerbaijan", "az", "994"],
      ["Bahamas", "bs", "1", 8, ["242"]],
      ["Bahrain", "bh", "973"],
      ["Bangladesh", "bd", "880"],
      ["Barbados", "bb", "1", 9, ["246"]],
      ["Belarus", "by", "375"],
      ["Belgium", "be", "32"],
      ["Belize", "bz", "501"],
      ["Benin", "bj", "229"],
      ["Bermuda", "bm", "1", 10, ["441"]],
      ["Bhutan", "bt", "975"],
      ["Bolivia", "bo", "591"],
      ["Bosnia & Herzegovina", "ba", "387"],
      ["Botswana", "bw", "267"],
      ["Brazil", "br", "55"],
      ["British Indian Ocean Territory", "io", "246"],
      ["British Virgin Islands", "vg", "1", 11, ["284"]],
      ["Brunei", "bn", "673"],
      ["Bulgaria", "bg", "359"],
      ["Burkina Faso", "bf", "226"],
      ["Burundi", "bi", "257"],
      ["Cambodia", "kh", "855"],
      ["Cameroon", "cm", "237"],
      [
        "Canada",
        "ca",
        "1",
        1,
        [
          "204",
          "226",
          "236",
          "249",
          "250",
          "263",
          "289",
          "306",
          "343",
          "354",
          "365",
          "367",
          "368",
          "382",
          "387",
          "403",
          "416",
          "418",
          "428",
          "431",
          "437",
          "438",
          "450",
          "584",
          "468",
          "474",
          "506",
          "514",
          "519",
          "548",
          "579",
          "581",
          "584",
          "587",
          "604",
          "613",
          "639",
          "647",
          "672",
          "683",
          "705",
          "709",
          "742",
          "753",
          "778",
          "780",
          "782",
          "807",
          "819",
          "825",
          "867",
          "873",
          "902",
          "905",
        ],
      ],
      ["Cape Verde", "cv", "238"],
      ["Caribbean Netherlands", "bq", "599", 1, ["3", "4", "7"]],
      ["Cayman Islands", "ky", "1", 12, ["345"]],
      ["Central African Republic", "cf", "236"],
      ["Chad", "td", "235"],
      ["Chile", "cl", "56"],
      ["China", "cn", "86"],
      ["Christmas Island", "cx", "61", 2, ["89164"]],
      ["Cocos (Keeling) Islands", "cc", "61", 1, ["89162"]],
      ["Colombia", "co", "57"],
      ["Comoros", "km", "269"],
      ["Congo - Brazzaville", "cg", "242"],
      ["Congo - Kinshasa", "cd", "243"],
      ["Cook Islands", "ck", "682"],
      ["Costa Rica", "cr", "506"],
      ["Côte d’Ivoire", "ci", "225"],
      ["Croatia", "hr", "385"],
      ["Cuba", "cu", "53"],
      ["Curaçao", "cw", "599", 0],
      ["Cyprus", "cy", "357"],
      ["Czech Republic", "cz", "420"],
      ["Denmark", "dk", "45"],
      ["Djibouti", "dj", "253"],
      ["Dominica", "dm", "1", 13, ["767"]],
      ["Dominican Republic", "do", "1", 2, ["809", "829", "849"]],
      ["Ecuador", "ec", "593"],
      ["Egypt", "eg", "20"],
      ["El Salvador", "sv", "503"],
      ["Equatorial Guinea", "gq", "240"],
      ["Eritrea", "er", "291"],
      ["Estonia", "ee", "372"],
      ["Eswatini", "sz", "268"],
      ["Ethiopia", "et", "251"],
      ["Falkland Islands", "fk", "500"],
      ["Faroe Islands", "fo", "298"],
      ["Fiji", "fj", "679"],
      ["Finland", "fi", "358", 0],
      ["France", "fr", "33"],
      ["French Guiana", "gf", "594"],
      ["French Polynesia", "pf", "689"],
      ["Gabon", "ga", "241"],
      ["Gambia", "gm", "220"],
      ["Georgia", "ge", "995"],
      ["Germany", "de", "49"],
      ["Ghana", "gh", "233"],
      ["Gibraltar", "gi", "350"],
      ["Greece", "gr", "30"],
      ["Greenland", "gl", "299"],
      ["Grenada", "gd", "1", 14, ["473"]],
      ["Guadeloupe", "gp", "590", 0],
      ["Guam", "gu", "1", 15, ["671"]],
      ["Guatemala", "gt", "502"],
      ["Guernsey", "gg", "44", 1, ["1481", "7781", "7839", "7911"]],
      ["Guinea", "gn", "224"],
      ["Guinea-Bissau", "gw", "245"],
      ["Guyana", "gy", "592"],
      ["Haiti", "ht", "509"],
      ["Honduras", "hn", "504"],
      ["Hong Kong", "hk", "852"],
      ["Hungary", "hu", "36"],
      ["Iceland", "is", "354"],
      ["India", "in", "91"],
      ["Indonesia", "id", "62"],
      ["Iran", "ir", "98"],
      ["Iraq", "iq", "964"],
      ["Ireland", "ie", "353"],
      ["Isle of Man", "im", "44", 2, ["1624", "74576", "7524", "7924", "7624"]],
      ["Israel", "il", "972"],
      ["Italy", "it", "39", 0],
      ["Jamaica", "jm", "1", 4, ["876", "658"]],
      ["Japan", "jp", "81"],
      [
        "Jersey",
        "je",
        "44",
        3,
        ["1534", "7509", "7700", "7797", "7829", "7937"],
      ],
      ["Jordan", "jo", "962"],
      ["Kazakhstan", "kz", "7", 1, ["33", "7"]],
      ["Kenya", "ke", "254"],
      ["Kiribati", "ki", "686"],
      ["Kosovo", "xk", "383"],
      ["Kuwait", "kw", "965"],
      ["Kyrgyzstan", "kg", "996"],
      ["Laos", "la", "856"],
      ["Latvia", "lv", "371"],
      ["Lebanon", "lb", "961"],
      ["Lesotho", "ls", "266"],
      ["Liberia", "lr", "231"],
      ["Libya", "ly", "218"],
      ["Liechtenstein", "li", "423"],
      ["Lithuania", "lt", "370"],
      ["Luxembourg", "lu", "352"],
      ["Macau", "mo", "853"],
      ["Madagascar", "mg", "261"],
      ["Malawi", "mw", "265"],
      ["Malaysia", "my", "60"],
      ["Maldives", "mv", "960"],
      ["Mali", "ml", "223"],
      ["Malta", "mt", "356"],
      ["Marshall Islands", "mh", "692"],
      ["Martinique", "mq", "596"],
      ["Mauritania", "mr", "222"],
      ["Mauritius", "mu", "230"],
      ["Mayotte", "yt", "262", 1, ["269", "639"]],
      ["Mexico", "mx", "52"],
      ["Micronesia", "fm", "691"],
      ["Moldova", "md", "373"],
      ["Monaco", "mc", "377"],
      ["Mongolia", "mn", "976"],
      ["Montenegro", "me", "382"],
      ["Montserrat", "ms", "1", 16, ["664"]],
      ["Morocco", "ma", "212", 0],
      ["Mozambique", "mz", "258"],
      ["Myanmar (Burma)", "mm", "95"],
      ["Namibia", "na", "264"],
      ["Nauru", "nr", "674"],
      ["Nepal", "np", "977"],
      ["Netherlands", "nl", "31"],
      ["New Caledonia", "nc", "687"],
      ["New Zealand", "nz", "64"],
      ["Nicaragua", "ni", "505"],
      ["Niger", "ne", "227"],
      ["Nigeria", "ng", "234"],
      ["Niue", "nu", "683"],
      ["Norfolk Island", "nf", "672"],
      ["North Korea", "kp", "850"],
      ["North Macedonia", "mk", "389"],
      ["Northern Mariana Islands", "mp", "1", 17, ["670"]],
      ["Norway", "no", "47", 0],
      ["Oman", "om", "968"],
      ["Pakistan", "pk", "92"],
      ["Palau", "pw", "680"],
      ["Palestine", "ps", "970"],
      ["Panama", "pa", "507"],
      ["Papua New Guinea", "pg", "675"],
      ["Paraguay", "py", "595"],
      ["Peru", "pe", "51"],
      ["Philippines", "ph", "63"],
      ["Poland", "pl", "48"],
      ["Portugal", "pt", "351"],
      ["Puerto Rico", "pr", "1", 3, ["787", "939"]],
      ["Qatar", "qa", "974"],
      ["Réunion", "re", "262", 0],
      ["Romania", "ro", "40"],
      ["Russia", "ru", "7", 0],
      ["Rwanda", "rw", "250"],
      ["Samoa", "ws", "685"],
      ["San Marino", "sm", "378"],
      ["São Tomé & Príncipe", "st", "239"],
      ["Saudi Arabia", "sa", "966"],
      ["Senegal", "sn", "221"],
      ["Serbia", "rs", "381"],
      ["Seychelles", "sc", "248"],
      ["Sierra Leone", "sl", "232"],
      ["Singapore", "sg", "65"],
      ["Sint Maarten", "sx", "1", 21, ["721"]],
      ["Slovakia", "sk", "421"],
      ["Slovenia", "si", "386"],
      ["Solomon Islands", "sb", "677"],
      ["Somalia", "so", "252"],
      ["South Africa", "za", "27"],
      ["South Korea", "kr", "82"],
      ["South Sudan", "ss", "211"],
      ["Spain", "es", "34"],
      ["Sri Lanka", "lk", "94"],
      ["St Barthélemy", "bl", "590", 1],
      ["St Helena", "sh", "290"],
      ["St Kitts & Nevis", "kn", "1", 18, ["869"]],
      ["St Lucia", "lc", "1", 19, ["758"]],
      ["St Martin", "mf", "590", 2],
      ["St Pierre & Miquelon", "pm", "508"],
      ["St Vincent & Grenadines", "vc", "1", 20, ["784"]],
      ["Sudan", "sd", "249"],
      ["Suriname", "sr", "597"],
      ["Svalbard & Jan Mayen", "sj", "47", 1, ["79"]],
      ["Sweden", "se", "46"],
      ["Switzerland", "ch", "41"],
      ["Syria", "sy", "963"],
      ["Taiwan", "tw", "886"],
      ["Tajikistan", "tj", "992"],
      ["Tanzania", "tz", "255"],
      ["Thailand", "th", "66"],
      ["Timor-Leste", "tl", "670"],
      ["Togo", "tg", "228"],
      ["Tokelau", "tk", "690"],
      ["Tonga", "to", "676"],
      ["Trinidad & Tobago", "tt", "1", 22, ["868"]],
      ["Tunisia", "tn", "216"],
      ["Turkey", "tr", "90"],
      ["Turkmenistan", "tm", "993"],
      ["Turks & Caicos Islands", "tc", "1", 23, ["649"]],
      ["Tuvalu", "tv", "688"],
      ["Uganda", "ug", "256"],
      ["Ukraine", "ua", "380"],
      ["United Arab Emirates", "ae", "971"],
      ["United Kingdom", "gb", "44", 0],
      ["United States", "us", "1", 0],
      ["Uruguay", "uy", "598"],
      ["US Virgin Islands", "vi", "1", 24, ["340"]],
      ["Uzbekistan", "uz", "998"],
      ["Vanuatu", "vu", "678"],
      ["Vatican City", "va", "39", 1, ["06698"]],
      ["Venezuela", "ve", "58"],
      ["Vietnam", "vn", "84"],
      ["Wallis & Futuna", "wf", "681"],
      ["Western Sahara", "eh", "212", 1, ["5288", "5289"]],
      ["Yemen", "ye", "967"],
      ["Zambia", "zm", "260"],
      ["Zimbabwe", "zw", "263"],
      ["Åland Islands", "ax", "358", 1, ["18"]],
    ];
    for (var n = 0; n < i.length; n++) {
      var o = i[n];
      i[n] = {
        name: o[0],
        iso2: o[1],
        dialCode: o[2],
        priority: o[3] || 0,
        areaCodes: o[4] || null,
        nodeById: {},
      };
    }
    ("use strict");
    function _objectSpread(t) {
      for (var e = 1; e < arguments.length; e++) {
        var i = arguments[e] != null ? Object(arguments[e]) : {};
        var n = Object.keys(i);
        typeof Object.getOwnPropertySymbols === "function" &&
          n.push.apply(
            n,
            Object.getOwnPropertySymbols(i).filter(function (t) {
              return Object.getOwnPropertyDescriptor(i, t).enumerable;
            }),
          );
        n.forEach(function (e) {
          _defineProperty(t, e, i[e]);
        });
      }
      return t;
    }
    function _defineProperty(t, e, i) {
      e = _toPropertyKey(e);
      e in t
        ? Object.defineProperty(t, e, {
            value: i,
            enumerable: true,
            configurable: true,
            writable: true,
          })
        : (t[e] = i);
      return t;
    }
    function _slicedToArray(t, e) {
      return (
        _arrayWithHoles(t) ||
        _iterableToArrayLimit(t, e) ||
        _unsupportedIterableToArray(t, e) ||
        _nonIterableRest()
      );
    }
    function _nonIterableRest() {
      throw new TypeError(
        "Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.",
      );
    }
    function _unsupportedIterableToArray(t, e) {
      if (t) {
        if (typeof t === "string") return _arrayLikeToArray(t, e);
        var i = Object.prototype.toString.call(t).slice(8, -1);
        i === "Object" && t.constructor && (i = t.constructor.name);
        return i === "Map" || i === "Set"
          ? Array.from(t)
          : i === "Arguments" ||
              /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(i)
            ? _arrayLikeToArray(t, e)
            : void 0;
      }
    }
    function _arrayLikeToArray(t, e) {
      (e == null || e > t.length) && (e = t.length);
      for (var i = 0, n = new Array(e); i < e; i++) n[i] = t[i];
      return n;
    }
    function _iterableToArrayLimit(t, e) {
      var i =
        null == t
          ? null
          : ("undefined" != typeof Symbol && t[Symbol.iterator]) ||
            t["@@iterator"];
      if (null != i) {
        var n,
          o,
          r,
          a,
          s = [],
          l = !0,
          u = !1;
        try {
          if (((r = (i = i.call(t)).next), 0 === e)) {
            if (Object(i) !== i) return;
            l = !1;
          } else
            for (
              ;
              !(l = (n = r.call(i)).done) && (s.push(n.value), s.length !== e);
              l = !0
            );
        } catch (t) {
          (u = !0), (o = t);
        } finally {
          try {
            if (!l && null != i.return && ((a = i.return()), Object(a) !== a))
              return;
          } finally {
            if (u) throw o;
          }
        }
        return s;
      }
    }
    function _arrayWithHoles(t) {
      if (Array.isArray(t)) return t;
    }
    function _classCallCheck(t, e) {
      if (!(t instanceof e))
        throw new TypeError("Cannot call a class as a function");
    }
    function _defineProperties(t, e) {
      for (var i = 0; i < e.length; i++) {
        var n = e[i];
        n.enumerable = n.enumerable || false;
        n.configurable = true;
        "value" in n && (n.writable = true);
        Object.defineProperty(t, _toPropertyKey(n.key), n);
      }
    }
    function _createClass(t, e, i) {
      e && _defineProperties(t.prototype, e);
      i && _defineProperties(t, i);
      Object.defineProperty(t, "prototype", { writable: false });
      return t;
    }
    function _toPropertyKey(t) {
      var e = _toPrimitive(t, "string");
      return typeof e === "symbol" ? e : String(e);
    }
    function _toPrimitive(t, i) {
      if (typeof t !== "object" || t === null) return t;
      var n = t[Symbol.toPrimitive];
      if (n !== e) {
        var o = n.call(t, i || "default");
        if (typeof o !== "object") return o;
        throw new TypeError("@@toPrimitive must return a primitive value.");
      }
      return (i === "string" ? String : Number)(t);
    }
    var r = {
      getInstance: function getInstance(t) {
        var e = t.getAttribute("data-intl-tel-input-id");
        return window.intlTelInputGlobals.instances[e];
      },
      instances: {},
      documentReady: function documentReady() {
        return document.readyState === "complete";
      },
    };
    typeof window === "object" && (window.intlTelInputGlobals = r);
    var a = 0;
    var s = {
      allowDropdown: true,
      autoInsertDialCode: false,
      autoPlaceholder: "polite",
      countrySearch: true,
      containerClass: "",
      customPlaceholder: null,
      dropdownContainer: null,
      excludeCountries: [],
      fixDropdownWidth: true,
      formatAsYouType: true,
      formatOnDisplay: true,
      geoIpLookup: null,
      hiddenInput: null,
      i18n: {},
      initialCountry: "",
      nationalMode: true,
      onlyCountries: [],
      placeholderNumberType: "MOBILE",
      preferredCountries: [],
      showFlags: true,
      showSelectedDialCode: false,
      useFullscreenPopup:
        typeof navigator !== "undefined" &&
        typeof window !== "undefined" &&
        (/Android.+Mobile|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
          navigator.userAgent,
        ) ||
          window.innerWidth <= 500),
      utilsScript: "",
    };
    var l = [
      "800",
      "822",
      "833",
      "844",
      "855",
      "866",
      "877",
      "880",
      "881",
      "882",
      "883",
      "884",
      "885",
      "886",
      "887",
      "888",
      "889",
    ];
    var u = function forEachInstance(t) {
      var e = window.intlTelInputGlobals.instances;
      Object.values(e).forEach(function (e) {
        return e[t]();
      });
    };
    var d = (function () {
      function Iti(i) {
        var n = arguments.length > 1 && arguments[1] !== e ? arguments[1] : {};
        _classCallCheck(this || t, Iti);
        (this || t).id = a++;
        (this || t).telInput = i;
        (this || t).activeItem = null;
        (this || t).highlightedItem = null;
        (this || t).options = Object.assign({}, s, n);
        (this || t).hadInitialPlaceholder = Boolean(
          i.getAttribute("placeholder"),
        );
      }
      _createClass(Iti, [
        {
          key: "_init",
          value: function _init() {
            var e = this || t;
            (this || t).options.useFullscreenPopup &&
              ((this || t).options.fixDropdownWidth = false);
            (this || t).options.countrySearch &&
              !(this || t).options.useFullscreenPopup &&
              ((this || t).options.fixDropdownWidth = true);
            (this || t).options.nationalMode &&
              ((this || t).options.autoInsertDialCode = false);
            (this || t).options.showSelectedDialCode &&
              ((this || t).options.autoInsertDialCode = false);
            var i =
              (this || t).options.allowDropdown &&
              !(this || t).options.showSelectedDialCode;
            !(this || t).options.showFlags &&
              i &&
              ((this || t).options.showFlags = true);
            (this || t).options.useFullscreenPopup &&
              !(this || t).options.dropdownContainer &&
              ((this || t).options.dropdownContainer = document.body);
            (this || t).isRTL = !!(this || t).telInput.closest("[dir=rtl]");
            if (typeof Promise !== "undefined") {
              var n = new Promise(function (t, i) {
                e.resolveAutoCountryPromise = t;
                e.rejectAutoCountryPromise = i;
              });
              var o = new Promise(function (t, i) {
                e.resolveUtilsScriptPromise = t;
                e.rejectUtilsScriptPromise = i;
              });
              (this || t).promise = Promise.all([n, o]);
            } else {
              (this || t).resolveAutoCountryPromise = (
                this || t
              ).rejectAutoCountryPromise = function () {};
              (this || t).resolveUtilsScriptPromise = (
                this || t
              ).rejectUtilsScriptPromise = function () {};
            }
            (this || t).selectedCountryData = {};
            this._processCountryData();
            this._generateMarkup();
            this._setInitialState();
            this._initListeners();
            this._initRequests();
          },
        },
        {
          key: "_processCountryData",
          value: function _processCountryData() {
            this._processAllCountries();
            this._processCountryCodes();
            this._processPreferredCountries();
            this._translateCountryNames();
            ((this || t).options.onlyCountries.length ||
              (this || t).options.i18n) &&
              (this || t).countries.sort((this || t)._countryNameSort);
          },
        },
        {
          key: "_addCountryCode",
          value: function _addCountryCode(i, n, o) {
            n.length > (this || t).countryCodeMaxLen &&
              ((this || t).countryCodeMaxLen = n.length);
            (this || t).countryCodes.hasOwnProperty(n) ||
              ((this || t).countryCodes[n] = []);
            for (var r = 0; r < (this || t).countryCodes[n].length; r++)
              if ((this || t).countryCodes[n][r] === i) return;
            var a = o !== e ? o : (this || t).countryCodes[n].length;
            (this || t).countryCodes[n][a] = i;
          },
        },
        {
          key: "_processAllCountries",
          value: function _processAllCountries() {
            if ((this || t).options.onlyCountries.length) {
              var e = (this || t).options.onlyCountries.map(function (t) {
                return t.toLowerCase();
              });
              (this || t).countries = i.filter(function (t) {
                return e.indexOf(t.iso2) > -1;
              });
            } else if ((this || t).options.excludeCountries.length) {
              var n = (this || t).options.excludeCountries.map(function (t) {
                return t.toLowerCase();
              });
              (this || t).countries = i.filter(function (t) {
                return n.indexOf(t.iso2) === -1;
              });
            } else (this || t).countries = i;
          },
        },
        {
          key: "_translateCountryNames",
          value: function _translateCountryNames() {
            for (var e = 0; e < (this || t).countries.length; e++) {
              var i = (this || t).countries[e].iso2.toLowerCase();
              (this || t).options.i18n.hasOwnProperty(i) &&
                ((this || t).countries[e].name = (this || t).options.i18n[i]);
            }
          },
        },
        {
          key: "_countryNameSort",
          value: function _countryNameSort(t, e) {
            return t.name < e.name ? -1 : t.name > e.name ? 1 : 0;
          },
        },
        {
          key: "_processCountryCodes",
          value: function _processCountryCodes() {
            (this || t).countryCodeMaxLen = 0;
            (this || t).dialCodes = {};
            (this || t).countryCodes = {};
            for (var e = 0; e < (this || t).countries.length; e++) {
              var i = (this || t).countries[e];
              (this || t).dialCodes[i.dialCode] ||
                ((this || t).dialCodes[i.dialCode] = true);
              this._addCountryCode(i.iso2, i.dialCode, i.priority);
            }
            for (var n = 0; n < (this || t).countries.length; n++) {
              var o = (this || t).countries[n];
              if (o.areaCodes) {
                var r = (this || t).countryCodes[o.dialCode][0];
                for (var a = 0; a < o.areaCodes.length; a++) {
                  var s = o.areaCodes[a];
                  for (var l = 1; l < s.length; l++) {
                    var u = o.dialCode + s.substr(0, l);
                    this._addCountryCode(r, u);
                    this._addCountryCode(o.iso2, u);
                  }
                  this._addCountryCode(o.iso2, o.dialCode + s);
                }
              }
            }
          },
        },
        {
          key: "_processPreferredCountries",
          value: function _processPreferredCountries() {
            (this || t).preferredCountries = [];
            for (
              var e = 0;
              e < (this || t).options.preferredCountries.length;
              e++
            ) {
              var i = (this || t).options.preferredCountries[e].toLowerCase();
              var n = this._getCountryData(i, false, true);
              n && (this || t).preferredCountries.push(n);
            }
          },
        },
        {
          key: "_createEl",
          value: function _createEl(t, e, i) {
            var n = document.createElement(t);
            e &&
              Object.entries(e).forEach(function (t) {
                var e = _slicedToArray(t, 2),
                  i = e[0],
                  o = e[1];
                return n.setAttribute(i, o);
              });
            i && i.appendChild(n);
            return n;
          },
        },
        {
          key: "_generateMarkup",
          value: function _generateMarkup() {
            (this || t).telInput.classList.add("iti__tel-input");
            (this || t).telInput.hasAttribute("autocomplete") ||
              ((this || t).telInput.form &&
                (this || t).telInput.form.hasAttribute("autocomplete")) ||
              (this || t).telInput.setAttribute("autocomplete", "off");
            var e = (this || t).options,
              i = e.allowDropdown,
              n = e.showSelectedDialCode,
              o = e.showFlags,
              r = e.containerClass,
              a = e.hiddenInput,
              s = e.dropdownContainer,
              l = e.fixDropdownWidth,
              u = e.useFullscreenPopup,
              d = e.countrySearch;
            var h = "iti";
            i && (h += " iti--allow-dropdown");
            n && (h += " iti--show-selected-dial-code");
            o && (h += " iti--show-flags");
            r && (h += " ".concat(r));
            u || (h += " iti--inline-dropdown");
            var c = this._createEl("div", { class: h });
            (this || t).telInput.parentNode.insertBefore(
              c,
              (this || t).telInput,
            );
            var p = i || o || n;
            p &&
              ((this || t).flagsContainer = this._createEl(
                "div",
                { class: "iti__flag-container" },
                c,
              ));
            c.appendChild((this || t).telInput);
            p &&
              ((this || t).selectedFlag = this._createEl(
                "div",
                _objectSpread(
                  { class: "iti__selected-flag" },
                  i && {
                    role: "combobox",
                    "aria-haspopup": "listbox",
                    "aria-controls": "iti-".concat(
                      (this || t).id,
                      "__country-listbox",
                    ),
                    "aria-expanded": "false",
                    "aria-label":
                      (this || t).options.i18n.selectedCountryAriaLabel ||
                      "Selected country",
                  },
                ),
                (this || t).flagsContainer,
              ));
            o &&
              ((this || t).selectedFlagInner = this._createEl(
                "div",
                { class: "iti__flag" },
                (this || t).selectedFlag,
              ));
            (this || t).selectedFlag &&
              (this || t).telInput.disabled &&
              (this || t).selectedFlag.setAttribute("aria-disabled", "true");
            n &&
              ((this || t).selectedDialCode = this._createEl(
                "div",
                { class: "iti__selected-dial-code" },
                (this || t).selectedFlag,
              ));
            if (i) {
              (this || t).telInput.disabled ||
                (this || t).selectedFlag.setAttribute("tabindex", "0");
              (this || t).dropdownArrow = this._createEl(
                "div",
                { class: "iti__arrow" },
                (this || t).selectedFlag,
              );
              var v = l ? "" : "iti--flexible-dropdown-width";
              (this || t).dropdownContent = this._createEl("div", {
                class: "iti__dropdown-content iti__hide ".concat(v),
              });
              d &&
                ((this || t).searchInput = this._createEl(
                  "input",
                  {
                    type: "text",
                    class: "iti__search-input",
                    placeholder:
                      (this || t).options.i18n.searchPlaceholder || "Search",
                  },
                  (this || t).dropdownContent,
                ));
              (this || t).countryList = this._createEl(
                "ul",
                {
                  class: "iti__country-list",
                  id: "iti-".concat((this || t).id, "__country-listbox"),
                  role: "listbox",
                  "aria-label":
                    (this || t).options.i18n.countryListAriaLabel ||
                    "List of countries",
                },
                (this || t).dropdownContent,
              );
              if ((this || t).preferredCountries.length && !d) {
                this._appendListItems(
                  (this || t).preferredCountries,
                  "iti__preferred",
                  true,
                );
                this._createEl(
                  "li",
                  { class: "iti__divider", "aria-hidden": "true" },
                  (this || t).countryList,
                );
              }
              this._appendListItems((this || t).countries, "iti__standard");
              if (s) {
                var f = "iti iti--container";
                f += u ? " iti--fullscreen-popup" : " iti--inline-dropdown";
                d && (f += " iti--country-search");
                (this || t).dropdown = this._createEl("div", { class: f });
                (this || t).dropdown.appendChild((this || t).dropdownContent);
              } else
                (this || t).flagsContainer.appendChild(
                  (this || t).dropdownContent,
                );
            }
            if (a) {
              var y = (this || t).telInput.getAttribute("name");
              var g = a(y);
              (this || t).hiddenInput = this._createEl("input", {
                type: "hidden",
                name: g,
              });
              c.appendChild((this || t).hiddenInput);
            }
          },
        },
        {
          key: "_appendListItems",
          value: function _appendListItems(e, i, n) {
            for (var o = 0; o < e.length; o++) {
              var r = e[o];
              var a = n ? "-preferred" : "";
              var s = this._createEl(
                "li",
                {
                  id: "iti-"
                    .concat((this || t).id, "__item-")
                    .concat(r.iso2)
                    .concat(a),
                  class: "iti__country ".concat(i),
                  tabindex: "-1",
                  role: "option",
                  "data-dial-code": r.dialCode,
                  "data-country-code": r.iso2,
                  "aria-selected": "false",
                },
                (this || t).countryList,
              );
              r.nodeById[(this || t).id] = s;
              var l = "";
              (this || t).options.showFlags &&
                (l +=
                  "<div class='iti__flag-box'><div class='iti__flag iti__".concat(
                    r.iso2,
                    "'></div></div>",
                  ));
              l += "<span class='iti__country-name'>".concat(r.name, "</span>");
              l += "<span class='iti__dial-code'>+".concat(
                r.dialCode,
                "</span>",
              );
              s.insertAdjacentHTML("beforeend", l);
            }
          },
        },
        {
          key: "_setInitialState",
          value: function _setInitialState() {
            var e = (this || t).telInput.getAttribute("value");
            var i = (this || t).telInput.value;
            var n = e && e.charAt(0) === "+" && (!i || i.charAt(0) !== "+");
            var o = n ? e : i;
            var r = this._getDialCode(o);
            var a = this._isRegionlessNanp(o);
            var s = (this || t).options,
              l = s.initialCountry,
              u = s.autoInsertDialCode;
            if (r && !a) this._updateFlagFromNumber(o);
            else if (l !== "auto") {
              var d = l && this._getCountryData(l, false, true);
              if (d) this._setFlag(l.toLowerCase());
              else if (r && a) this._setFlag("us");
              else {
                (this || t).defaultCountry = (this || t).preferredCountries
                  .length
                  ? (this || t).preferredCountries[0].iso2
                  : (this || t).countries[0].iso2;
                o || this._setFlag((this || t).defaultCountry);
              }
              !o &&
                u &&
                ((this || t).telInput.value = "+".concat(
                  (this || t).selectedCountryData.dialCode,
                ));
            }
            o && this._updateValFromNumber(o);
          },
        },
        {
          key: "_initListeners",
          value: function _initListeners() {
            this._initKeyListeners();
            (this || t).options.autoInsertDialCode && this._initBlurListeners();
            (this || t).options.allowDropdown && this._initDropdownListeners();
            (this || t).hiddenInput && this._initHiddenInputListener();
          },
        },
        {
          key: "_initHiddenInputListener",
          value: function _initHiddenInputListener() {
            var e = this || t;
            (this || t)._handleHiddenInputSubmit = function () {
              e.hiddenInput.value = e.getNumber();
            };
            (this || t).telInput.form &&
              (this || t).telInput.form.addEventListener(
                "submit",
                (this || t)._handleHiddenInputSubmit,
              );
          },
        },
        {
          key: "_initDropdownListeners",
          value: function _initDropdownListeners() {
            var e = this || t;
            (this || t)._handleLabelClick = function (t) {
              e.dropdownContent.classList.contains("iti__hide")
                ? e.telInput.focus()
                : t.preventDefault();
            };
            var i = (this || t).telInput.closest("label");
            i && i.addEventListener("click", (this || t)._handleLabelClick);
            (this || t)._handleClickSelectedFlag = function () {
              !e.dropdownContent.classList.contains("iti__hide") ||
                e.telInput.disabled ||
                e.telInput.readOnly ||
                e._showDropdown();
            };
            (this || t).selectedFlag.addEventListener(
              "click",
              (this || t)._handleClickSelectedFlag,
            );
            (this || t)._handleFlagsContainerKeydown = function (t) {
              var i = e.dropdownContent.classList.contains("iti__hide");
              if (i && ["ArrowUp", "ArrowDown", " ", "Enter"].includes(t.key)) {
                t.preventDefault();
                t.stopPropagation();
                e._showDropdown();
              }
              t.key === "Tab" && e._closeDropdown();
            };
            (this || t).flagsContainer.addEventListener(
              "keydown",
              (this || t)._handleFlagsContainerKeydown,
            );
          },
        },
        {
          key: "_initRequests",
          value: function _initRequests() {
            var e = this || t;
            (this || t).options.utilsScript && !window.intlTelInputUtils
              ? window.intlTelInputGlobals.documentReady()
                ? window.intlTelInputGlobals.loadUtils(
                    (this || t).options.utilsScript,
                  )
                : window.addEventListener("load", function () {
                    window.intlTelInputGlobals.loadUtils(e.options.utilsScript);
                  })
              : this.resolveUtilsScriptPromise();
            (this || t).options.initialCountry === "auto"
              ? this._loadAutoCountry()
              : this.resolveAutoCountryPromise();
          },
        },
        {
          key: "_loadAutoCountry",
          value: function _loadAutoCountry() {
            if (window.intlTelInputGlobals.autoCountry)
              this.handleAutoCountry();
            else if (!window.intlTelInputGlobals.startedLoadingAutoCountry) {
              window.intlTelInputGlobals.startedLoadingAutoCountry = true;
              typeof (this || t).options.geoIpLookup === "function" &&
                (this || t).options.geoIpLookup(
                  function (t) {
                    window.intlTelInputGlobals.autoCountry = t.toLowerCase();
                    setTimeout(function () {
                      return u("handleAutoCountry");
                    });
                  },
                  function () {
                    return u("rejectAutoCountryPromise");
                  },
                );
            }
          },
        },
        {
          key: "_initKeyListeners",
          value: function _initKeyListeners() {
            var e = this || t;
            var i = false;
            (this || t)._handleKeyEvent = function (t) {
              e._updateFlagFromNumber(e.telInput.value) &&
                e._triggerCountryChange();
              t && t.data && /[^+0-9]/.test(t.data)
                ? (i = true)
                : /[^+0-9]/.test(e.telInput.value) || (i = false);
              if (e.options.formatAsYouType && !i) {
                var n = e.telInput.selectionStart;
                var o = e.telInput.value.substring(0, n);
                var r = o.replace(/[^+0-9]/g, "").length;
                var a = t && t.inputType === "deleteContentForward";
                var s = e._formatNumberAsYouType();
                var l = e._translateCursorPosition(r, s, n, a);
                e.telInput.value = s;
                e.telInput.setSelectionRange(l, l);
              }
            };
            (this || t).telInput.addEventListener(
              "input",
              (this || t)._handleKeyEvent,
            );
            (this || t)._handleClipboardEvent = function () {
              setTimeout(e._handleKeyEvent);
            };
            (this || t).telInput.addEventListener(
              "cut",
              (this || t)._handleClipboardEvent,
            );
            (this || t).telInput.addEventListener(
              "paste",
              (this || t)._handleClipboardEvent,
            );
          },
        },
        {
          key: "_translateCursorPosition",
          value: function _translateCursorPosition(t, e, i, n) {
            if (i === 0 && !n) return 0;
            var o = 0;
            for (var r = 0; r < e.length; r++) {
              /[+0-9]/.test(e[r]) && o++;
              if (o === t && !n) return r + 1;
              if (n && o === t + 1) return r;
            }
            return e.length;
          },
        },
        {
          key: "_cap",
          value: function _cap(e) {
            var i = (this || t).telInput.getAttribute("maxlength");
            return i && e.length > i ? e.substr(0, i) : e;
          },
        },
        {
          key: "_initBlurListeners",
          value: function _initBlurListeners() {
            var e = this || t;
            (this || t)._handleSubmitOrBlurEvent = function () {
              e._removeEmptyDialCode();
            };
            (this || t).telInput.form &&
              (this || t).telInput.form.addEventListener(
                "submit",
                (this || t)._handleSubmitOrBlurEvent,
              );
            (this || t).telInput.addEventListener(
              "blur",
              (this || t)._handleSubmitOrBlurEvent,
            );
          },
        },
        {
          key: "_removeEmptyDialCode",
          value: function _removeEmptyDialCode() {
            if ((this || t).telInput.value.charAt(0) === "+") {
              var e = this._getNumeric((this || t).telInput.value);
              (e && (this || t).selectedCountryData.dialCode !== e) ||
                ((this || t).telInput.value = "");
            }
          },
        },
        {
          key: "_getNumeric",
          value: function _getNumeric(t) {
            return t.replace(/\D/g, "");
          },
        },
        {
          key: "_trigger",
          value: function _trigger(e) {
            var i = new Event(e, { bubbles: true, cancelable: true });
            (this || t).telInput.dispatchEvent(i);
          },
        },
        {
          key: "_showDropdown",
          value: function _showDropdown() {
            (this || t).options.fixDropdownWidth &&
              ((this || t).dropdownContent.style.width = "".concat(
                (this || t).telInput.offsetWidth,
                "px",
              ));
            (this || t).dropdownContent.classList.remove("iti__hide");
            (this || t).selectedFlag.setAttribute("aria-expanded", "true");
            this._setDropdownPosition();
            if ((this || t).options.countrySearch) {
              var e = (this || t).countryList.firstElementChild;
              e && this._highlightListItem(e, false);
              (this || t).searchInput.focus();
            } else if ((this || t).activeItem) {
              this._highlightListItem((this || t).activeItem, false);
              this._scrollTo((this || t).activeItem, true);
            }
            this._bindDropdownListeners();
            (this || t).dropdownArrow.classList.add("iti__arrow--up");
            this._trigger("open:countrydropdown");
          },
        },
        {
          key: "_toggleClass",
          value: function _toggleClass(t, e, i) {
            i && !t.classList.contains(e)
              ? t.classList.add(e)
              : !i && t.classList.contains(e) && t.classList.remove(e);
          },
        },
        {
          key: "_setDropdownPosition",
          value: function _setDropdownPosition() {
            var e = this || t;
            (this || t).options.dropdownContainer &&
              (this || t).options.dropdownContainer.appendChild(
                (this || t).dropdown,
              );
            if (!(this || t).options.useFullscreenPopup) {
              var i = (this || t).telInput.getBoundingClientRect();
              var n = document.documentElement.scrollTop;
              var o = i.top + n;
              var r = (this || t).dropdownContent.offsetHeight;
              var a =
                o + (this || t).telInput.offsetHeight + r <
                n + window.innerHeight;
              var s = o - r > n;
              var l = !(this || t).options.countrySearch && !a && s;
              this._toggleClass(
                (this || t).dropdownContent,
                "iti__dropdown-content--dropup",
                l,
              );
              if ((this || t).options.dropdownContainer) {
                var u = l ? 0 : (this || t).telInput.offsetHeight;
                (this || t).dropdown.style.top = "".concat(o + u, "px");
                (this || t).dropdown.style.left = "".concat(
                  i.left + document.body.scrollLeft,
                  "px",
                );
                (this || t)._handleWindowScroll = function () {
                  return e._closeDropdown();
                };
                window.addEventListener(
                  "scroll",
                  (this || t)._handleWindowScroll,
                );
              }
            }
          },
        },
        {
          key: "_bindDropdownListeners",
          value: function _bindDropdownListeners() {
            var e = this || t;
            (this || t)._handleMouseoverCountryList = function (t) {
              var i = t.target.closest(".iti__country");
              i && e._highlightListItem(i, false);
            };
            (this || t).countryList.addEventListener(
              "mouseover",
              (this || t)._handleMouseoverCountryList,
            );
            (this || t)._handleClickCountryList = function (t) {
              var i = t.target.closest(".iti__country");
              i && e._selectListItem(i);
            };
            (this || t).countryList.addEventListener(
              "click",
              (this || t)._handleClickCountryList,
            );
            var i = true;
            (this || t)._handleClickOffToClose = function () {
              i || e._closeDropdown();
              i = false;
            };
            document.documentElement.addEventListener(
              "click",
              (this || t)._handleClickOffToClose,
            );
            var n = "";
            var o = null;
            (this || t)._handleKeydownOnDropdown = function (t) {
              if (["ArrowUp", "ArrowDown", "Enter", "Escape"].includes(t.key)) {
                t.preventDefault();
                t.stopPropagation();
                t.key === "ArrowUp" || t.key === "ArrowDown"
                  ? e._handleUpDownKey(t.key)
                  : t.key === "Enter"
                    ? e._handleEnterKey()
                    : t.key === "Escape" && e._closeDropdown();
              }
              if (
                !e.options.countrySearch &&
                /^[a-zA-ZÀ-ÿа-яА-Я ]$/.test(t.key)
              ) {
                t.stopPropagation();
                o && clearTimeout(o);
                n += t.key.toLowerCase();
                e._searchForCountry(n);
                o = setTimeout(function () {
                  n = "";
                }, 1e3);
              }
            };
            document.addEventListener(
              "keydown",
              (this || t)._handleKeydownOnDropdown,
            );
            if ((this || t).options.countrySearch) {
              var r = function doFilter() {
                var t = e.searchInput.value.trim();
                t ? e._filterCountries(t) : e._filterCountries("", true);
              };
              var a = null;
              (this || t)._handleSearchChange = function () {
                a && clearTimeout(a);
                a = setTimeout(function () {
                  r();
                  a = null;
                }, 100);
              };
              (this || t).searchInput.addEventListener(
                "input",
                (this || t)._handleSearchChange,
              );
              (this || t).searchInput.addEventListener("click", function (t) {
                return t.stopPropagation();
              });
            }
          },
        },
        {
          key: "_normaliseString",
          value: function _normaliseString() {
            var t =
              arguments.length > 0 && arguments[0] !== e ? arguments[0] : "";
            return t
              .normalize("NFD")
              .replace(/[\u0300-\u036f]/g, "")
              .toLowerCase();
          },
        },
        {
          key: "_filterCountries",
          value: function _filterCountries(i) {
            var n = arguments.length > 1 && arguments[1] !== e && arguments[1];
            var o = true;
            (this || t).countryList.innerHTML = "";
            var r = this._normaliseString(i);
            for (var a = 0; a < (this || t).countries.length; a++) {
              var s = (this || t).countries[a];
              var l = this._normaliseString(s.name);
              var u = "+".concat(s.dialCode);
              if (n || l.includes(r) || u.includes(r) || s.iso2.includes(r)) {
                (this || t).countryList.appendChild(s.nodeById[(this || t).id]);
                if (o) {
                  this._highlightListItem(s.nodeById[(this || t).id], false);
                  o = false;
                }
              }
            }
          },
        },
        {
          key: "_handleUpDownKey",
          value: function _handleUpDownKey(e) {
            var i =
              e === "ArrowUp"
                ? (this || t).highlightedItem.previousElementSibling
                : (this || t).highlightedItem.nextElementSibling;
            i
              ? i.classList.contains("iti__divider") &&
                (i =
                  e === "ArrowUp"
                    ? i.previousElementSibling
                    : i.nextElementSibling)
              : (this || t).countryList.childElementCount > 1 &&
                (i =
                  e === "ArrowUp"
                    ? (this || t).countryList.lastElementChild
                    : (this || t).countryList.firstElementChild);
            if (i) {
              var n = !(this || t).options.countrySearch;
              this._highlightListItem(i, n);
              (this || t).options.countrySearch && this._scrollTo(i, false);
            }
          },
        },
        {
          key: "_handleEnterKey",
          value: function _handleEnterKey() {
            (this || t).highlightedItem &&
              this._selectListItem((this || t).highlightedItem);
          },
        },
        {
          key: "_searchForCountry",
          value: function _searchForCountry(e) {
            for (var i = 0; i < (this || t).countries.length; i++)
              if (this._startsWith((this || t).countries[i].name, e)) {
                var n = (this || t).countries[i].nodeById[(this || t).id];
                this._highlightListItem(n, false);
                this._scrollTo(n, true);
                break;
              }
          },
        },
        {
          key: "_startsWith",
          value: function _startsWith(t, e) {
            return t.substr(0, e.length).toLowerCase() === e;
          },
        },
        {
          key: "_updateValFromNumber",
          value: function _updateValFromNumber(e) {
            var i = e;
            if (
              (this || t).options.formatOnDisplay &&
              window.intlTelInputUtils &&
              (this || t).selectedCountryData
            ) {
              var n =
                (this || t).options.nationalMode ||
                (i.charAt(0) !== "+" &&
                  !(this || t).options.showSelectedDialCode);
              var o = intlTelInputUtils.numberFormat,
                r = o.NATIONAL,
                a = o.INTERNATIONAL;
              var s = n ? r : a;
              i = intlTelInputUtils.formatNumber(
                i,
                (this || t).selectedCountryData.iso2,
                s,
              );
            }
            i = this._beforeSetNumber(i);
            (this || t).telInput.value = i;
          },
        },
        {
          key: "_updateFlagFromNumber",
          value: function _updateFlagFromNumber(e) {
            var i = e.indexOf("+");
            var n = i ? e.substring(i) : e;
            var o = (this || t).selectedCountryData.dialCode;
            var r = o === "1";
            if (n && r && n.charAt(0) !== "+") {
              n.charAt(0) !== "1" && (n = "1".concat(n));
              n = "+".concat(n);
            }
            (this || t).options.showSelectedDialCode &&
              o &&
              n.charAt(0) !== "+" &&
              (n = "+".concat(o).concat(n));
            var a = this._getDialCode(n, true);
            var s = this._getNumeric(n);
            var l = null;
            if (a) {
              var u = (this || t).countryCodes[this._getNumeric(a)];
              var d =
                u.indexOf((this || t).selectedCountryData.iso2) !== -1 &&
                s.length <= a.length - 1;
              var h = o === "1" && this._isRegionlessNanp(s);
              if (!h && !d)
                for (var c = 0; c < u.length; c++)
                  if (u[c]) {
                    l = u[c];
                    break;
                  }
            } else
              n.charAt(0) === "+" && s.length
                ? (l = "")
                : (n && n !== "+") || (l = (this || t).defaultCountry);
            return l !== null && this._setFlag(l);
          },
        },
        {
          key: "_isRegionlessNanp",
          value: function _isRegionlessNanp(t) {
            var e = this._getNumeric(t);
            if (e.charAt(0) === "1") {
              var i = e.substr(1, 3);
              return l.indexOf(i) !== -1;
            }
            return false;
          },
        },
        {
          key: "_highlightListItem",
          value: function _highlightListItem(e, i) {
            var n = (this || t).highlightedItem;
            n && n.classList.remove("iti__highlight");
            (this || t).highlightedItem = e;
            (this || t).highlightedItem.classList.add("iti__highlight");
            (this || t).selectedFlag.setAttribute(
              "aria-activedescendant",
              e.getAttribute("id"),
            );
            i && (this || t).highlightedItem.focus();
          },
        },
        {
          key: "_getCountryData",
          value: function _getCountryData(e, n, o) {
            var r = n ? i : (this || t).countries;
            for (var a = 0; a < r.length; a++) if (r[a].iso2 === e) return r[a];
            if (o) return null;
            throw new Error("No country data for '".concat(e, "'"));
          },
        },
        {
          key: "_setFlag",
          value: function _setFlag(e) {
            var i = (this || t).options,
              n = i.allowDropdown,
              o = i.showSelectedDialCode,
              r = i.showFlags,
              a = i.countrySearch;
            var s = (this || t).selectedCountryData.iso2
              ? (this || t).selectedCountryData
              : {};
            (this || t).selectedCountryData = e
              ? this._getCountryData(e, false, false)
              : {};
            (this || t).selectedCountryData.iso2 &&
              ((this || t).defaultCountry = (
                this || t
              ).selectedCountryData.iso2);
            r &&
              (this || t).selectedFlagInner.setAttribute(
                "class",
                "iti__flag iti__".concat(e),
              );
            this._setSelectedCountryFlagTitleAttribute(e, o);
            if (o) {
              var l = (this || t).selectedCountryData.dialCode
                ? "+".concat((this || t).selectedCountryData.dialCode)
                : "";
              (this || t).selectedDialCode.innerHTML = l;
              var u =
                (this || t).selectedFlag.offsetWidth ||
                this._getHiddenSelectedFlagWidth();
              (this || t).isRTL
                ? ((this || t).telInput.style.paddingRight = "".concat(
                    u + 6,
                    "px",
                  ))
                : ((this || t).telInput.style.paddingLeft = "".concat(
                    u + 6,
                    "px",
                  ));
            }
            this._updatePlaceholder();
            if (n && !a) {
              var d = (this || t).activeItem;
              if (d) {
                d.classList.remove("iti__active");
                d.setAttribute("aria-selected", "false");
              }
              if (e) {
                var h =
                  (this || t).countryList.querySelector(
                    "#iti-"
                      .concat((this || t).id, "__item-")
                      .concat(e, "-preferred"),
                  ) ||
                  (this || t).countryList.querySelector(
                    "#iti-".concat((this || t).id, "__item-").concat(e),
                  );
                h.setAttribute("aria-selected", "true");
                h.classList.add("iti__active");
                (this || t).activeItem = h;
              }
            }
            return s.iso2 !== e;
          },
        },
        {
          key: "_setSelectedCountryFlagTitleAttribute",
          value: function _setSelectedCountryFlagTitleAttribute(e, i) {
            if ((this || t).selectedFlag) {
              var n;
              n =
                e && !i
                  ? ""
                      .concat((this || t).selectedCountryData.name, ": +")
                      .concat((this || t).selectedCountryData.dialCode)
                  : e
                    ? (this || t).selectedCountryData.name
                    : "Unknown";
              (this || t).selectedFlag.setAttribute("title", n);
            }
          },
        },
        {
          key: "_getHiddenSelectedFlagWidth",
          value: function _getHiddenSelectedFlagWidth() {
            var e = (this || t).telInput.parentNode.cloneNode();
            e.style.visibility = "hidden";
            document.body.appendChild(e);
            var i = (this || t).flagsContainer.cloneNode();
            e.appendChild(i);
            var n = (this || t).selectedFlag.cloneNode(true);
            i.appendChild(n);
            var o = n.offsetWidth;
            e.parentNode.removeChild(e);
            return o;
          },
        },
        {
          key: "_updatePlaceholder",
          value: function _updatePlaceholder() {
            var e =
              (this || t).options.autoPlaceholder === "aggressive" ||
              (!(this || t).hadInitialPlaceholder &&
                (this || t).options.autoPlaceholder === "polite");
            if (window.intlTelInputUtils && e) {
              var i =
                intlTelInputUtils.numberType[
                  (this || t).options.placeholderNumberType
                ];
              var n = (this || t).selectedCountryData.iso2
                ? intlTelInputUtils.getExampleNumber(
                    (this || t).selectedCountryData.iso2,
                    (this || t).options.nationalMode,
                    i,
                  )
                : "";
              n = this._beforeSetNumber(n);
              typeof (this || t).options.customPlaceholder === "function" &&
                (n = (this || t).options.customPlaceholder(
                  n,
                  (this || t).selectedCountryData,
                ));
              (this || t).telInput.setAttribute("placeholder", n);
            }
          },
        },
        {
          key: "_selectListItem",
          value: function _selectListItem(e) {
            var i = this._setFlag(e.getAttribute("data-country-code"));
            this._closeDropdown();
            this._updateDialCode(e.getAttribute("data-dial-code"));
            (this || t).telInput.focus();
            i && this._triggerCountryChange();
          },
        },
        {
          key: "_closeDropdown",
          value: function _closeDropdown() {
            (this || t).dropdownContent.classList.add("iti__hide");
            (this || t).selectedFlag.setAttribute("aria-expanded", "false");
            (this || t).selectedFlag.removeAttribute("aria-activedescendant");
            (this || t).dropdownArrow.classList.remove("iti__arrow--up");
            document.removeEventListener(
              "keydown",
              (this || t)._handleKeydownOnDropdown,
            );
            (this || t).options.countrySearch &&
              (this || t).searchInput.removeEventListener(
                "input",
                (this || t)._handleSearchChange,
              );
            document.documentElement.removeEventListener(
              "click",
              (this || t)._handleClickOffToClose,
            );
            (this || t).countryList.removeEventListener(
              "mouseover",
              (this || t)._handleMouseoverCountryList,
            );
            (this || t).countryList.removeEventListener(
              "click",
              (this || t)._handleClickCountryList,
            );
            if ((this || t).options.dropdownContainer) {
              (this || t).options.useFullscreenPopup ||
                window.removeEventListener(
                  "scroll",
                  (this || t)._handleWindowScroll,
                );
              (this || t).dropdown.parentNode &&
                (this || t).dropdown.parentNode.removeChild(
                  (this || t).dropdown,
                );
            }
            this._trigger("close:countrydropdown");
          },
        },
        {
          key: "_scrollTo",
          value: function _scrollTo(e, i) {
            var n = (this || t).countryList;
            var o = document.documentElement.scrollTop;
            var r = n.offsetHeight;
            var a = n.getBoundingClientRect().top + o;
            var s = a + r;
            var l = e.offsetHeight;
            var u = e.getBoundingClientRect().top + o;
            var d = u + l;
            var h = u - a + n.scrollTop;
            var c = r / 2 - l / 2;
            if (u < a) {
              i && (h -= c);
              n.scrollTop = h;
            } else if (d > s) {
              i && (h += c);
              var p = r - l;
              n.scrollTop = h - p;
            }
          },
        },
        {
          key: "_updateDialCode",
          value: function _updateDialCode(e) {
            var i = (this || t).telInput.value;
            var n = "+".concat(e);
            var o;
            if (i.charAt(0) === "+") {
              var r = this._getDialCode(i);
              o = r ? i.replace(r, n) : n;
              (this || t).telInput.value = o;
            } else if ((this || t).options.autoInsertDialCode) {
              o = i ? n + i : n;
              (this || t).telInput.value = o;
            }
          },
        },
        {
          key: "_getDialCode",
          value: function _getDialCode(e, i) {
            var n = "";
            if (e.charAt(0) === "+") {
              var o = "";
              for (var r = 0; r < e.length; r++) {
                var a = e.charAt(r);
                if (!isNaN(parseInt(a, 10))) {
                  o += a;
                  if (i)
                    (this || t).countryCodes[o] && (n = e.substr(0, r + 1));
                  else if ((this || t).dialCodes[o]) {
                    n = e.substr(0, r + 1);
                    break;
                  }
                  if (o.length === (this || t).countryCodeMaxLen) break;
                }
              }
            }
            return n;
          },
        },
        {
          key: "_getFullNumber",
          value: function _getFullNumber() {
            var e = (this || t).telInput.value.trim();
            var i = (this || t).selectedCountryData.dialCode;
            var n;
            var o = this._getNumeric(e);
            n =
              (this || t).options.showSelectedDialCode &&
              !(this || t).options.nationalMode &&
              e.charAt(0) !== "+" &&
              i &&
              o
                ? "+".concat(i)
                : "";
            return n + e;
          },
        },
        {
          key: "_beforeSetNumber",
          value: function _beforeSetNumber(e) {
            var i = e;
            if ((this || t).options.showSelectedDialCode) {
              var n = this._getDialCode(i);
              if (n) {
                n = "+".concat((this || t).selectedCountryData.dialCode);
                var o =
                  i[n.length] === " " || i[n.length] === "-"
                    ? n.length + 1
                    : n.length;
                i = i.substr(o);
              }
            }
            return this._cap(i);
          },
        },
        {
          key: "_triggerCountryChange",
          value: function _triggerCountryChange() {
            this._trigger("countrychange");
          },
        },
        {
          key: "_formatNumberAsYouType",
          value: function _formatNumberAsYouType() {
            var e = this._getFullNumber();
            var i = window.intlTelInputUtils
              ? intlTelInputUtils.formatNumberAsYouType(
                  e,
                  (this || t).selectedCountryData.iso2,
                )
              : e;
            var n = (this || t).selectedCountryData.dialCode;
            if (
              (this || t).options.showSelectedDialCode &&
              !(this || t).options.nationalMode &&
              (this || t).telInput.value.charAt(0) !== "+" &&
              i.includes("+".concat(n))
            ) {
              var o = i.split("+".concat(n))[1] || "";
              return o.trim();
            }
            return i;
          },
        },
        {
          key: "handleAutoCountry",
          value: function handleAutoCountry() {
            if ((this || t).options.initialCountry === "auto") {
              (this || t).defaultCountry =
                window.intlTelInputGlobals.autoCountry;
              (this || t).telInput.value ||
                this.setCountry((this || t).defaultCountry);
              this.resolveAutoCountryPromise();
            }
          },
        },
        {
          key: "handleUtils",
          value: function handleUtils() {
            if (window.intlTelInputUtils) {
              (this || t).telInput.value &&
                this._updateValFromNumber((this || t).telInput.value);
              this._updatePlaceholder();
            }
            this.resolveUtilsScriptPromise();
          },
        },
        {
          key: "destroy",
          value: function destroy() {
            var e = (this || t).telInput.form;
            if ((this || t).options.allowDropdown) {
              this._closeDropdown();
              (this || t).selectedFlag.removeEventListener(
                "click",
                (this || t)._handleClickSelectedFlag,
              );
              (this || t).flagsContainer.removeEventListener(
                "keydown",
                (this || t)._handleFlagsContainerKeydown,
              );
              var i = (this || t).telInput.closest("label");
              i &&
                i.removeEventListener("click", (this || t)._handleLabelClick);
            }
            (this || t).hiddenInput &&
              e &&
              e.removeEventListener(
                "submit",
                (this || t)._handleHiddenInputSubmit,
              );
            if ((this || t).options.autoInsertDialCode) {
              e &&
                e.removeEventListener(
                  "submit",
                  (this || t)._handleSubmitOrBlurEvent,
                );
              (this || t).telInput.removeEventListener(
                "blur",
                (this || t)._handleSubmitOrBlurEvent,
              );
            }
            (this || t).telInput.removeEventListener(
              "input",
              (this || t)._handleKeyEvent,
            );
            (this || t).telInput.removeEventListener(
              "cut",
              (this || t)._handleClipboardEvent,
            );
            (this || t).telInput.removeEventListener(
              "paste",
              (this || t)._handleClipboardEvent,
            );
            (this || t).telInput.removeAttribute("data-intl-tel-input-id");
            var n = (this || t).telInput.parentNode;
            n.parentNode.insertBefore((this || t).telInput, n);
            n.parentNode.removeChild(n);
            delete window.intlTelInputGlobals.instances[(this || t).id];
          },
        },
        {
          key: "getExtension",
          value: function getExtension() {
            return window.intlTelInputUtils
              ? intlTelInputUtils.getExtension(
                  this._getFullNumber(),
                  (this || t).selectedCountryData.iso2,
                )
              : "";
          },
        },
        {
          key: "getNumber",
          value: function getNumber(e) {
            if (window.intlTelInputUtils) {
              var i = (this || t).selectedCountryData.iso2;
              return intlTelInputUtils.formatNumber(
                this._getFullNumber(),
                i,
                e,
              );
            }
            return "";
          },
        },
        {
          key: "getNumberType",
          value: function getNumberType() {
            return window.intlTelInputUtils
              ? intlTelInputUtils.getNumberType(
                  this._getFullNumber(),
                  (this || t).selectedCountryData.iso2,
                )
              : -99;
          },
        },
        {
          key: "getSelectedCountryData",
          value: function getSelectedCountryData() {
            return (this || t).selectedCountryData;
          },
        },
        {
          key: "getValidationError",
          value: function getValidationError() {
            if (window.intlTelInputUtils) {
              var e = (this || t).selectedCountryData.iso2;
              return intlTelInputUtils.getValidationError(
                this._getFullNumber(),
                e,
              );
            }
            return -99;
          },
        },
        {
          key: "isValidNumber",
          value: function isValidNumber() {
            var e = this._getFullNumber();
            return window.intlTelInputUtils
              ? intlTelInputUtils.isPossibleNumber(
                  e,
                  (this || t).selectedCountryData.iso2,
                )
              : null;
          },
        },
        {
          key: "isValidNumberPrecise",
          value: function isValidNumberPrecise() {
            var e = this._getFullNumber();
            return window.intlTelInputUtils
              ? intlTelInputUtils.isValidNumber(
                  e,
                  (this || t).selectedCountryData.iso2,
                )
              : null;
          },
        },
        {
          key: "setCountry",
          value: function setCountry(e) {
            var i = e.toLowerCase();
            if ((this || t).selectedCountryData.iso2 !== i) {
              this._setFlag(i);
              this._updateDialCode((this || t).selectedCountryData.dialCode);
              this._triggerCountryChange();
            }
          },
        },
        {
          key: "setNumber",
          value: function setNumber(t) {
            var e = this._updateFlagFromNumber(t);
            this._updateValFromNumber(t);
            e && this._triggerCountryChange();
          },
        },
        {
          key: "setPlaceholderNumberType",
          value: function setPlaceholderNumberType(e) {
            (this || t).options.placeholderNumberType = e;
            this._updatePlaceholder();
          },
        },
      ]);
      return Iti;
    })();
    r.getCountryData = function () {
      return i;
    };
    var h = function injectScript(t, e, i) {
      var n = document.createElement("script");
      n.onload = function () {
        u("handleUtils");
        e && e();
      };
      n.onerror = function () {
        u("rejectUtilsScriptPromise");
        i && i();
      };
      n.className = "iti-load-utils";
      n.async = true;
      n.src = t;
      document.body.appendChild(n);
    };
    r.loadUtils = function (t) {
      if (
        !window.intlTelInputUtils &&
        !window.intlTelInputGlobals.startedLoadingUtilsScript
      ) {
        window.intlTelInputGlobals.startedLoadingUtilsScript = true;
        if (typeof Promise !== "undefined")
          return new Promise(function (e, i) {
            return h(t, e, i);
          });
        h(t);
      }
      return null;
    };
    r.defaults = s;
    r.version = "19.2.16";
    return function (t, e) {
      var i = new d(t, e);
      i._init();
      t.setAttribute("data-intl-tel-input-id", i.id);
      window.intlTelInputGlobals.instances[i.id] = i;
      return i;
    };
  })();
});
var i = e;
export { i as default };
