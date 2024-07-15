# frozen_string_literal: true

pin "application"
pin "i18n"
pin "debounce"
pin "constants"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "intl-tel-input" # @23.3.2
pin "intl-tel-input/build/js/utils.js",
    to: "intl-tel-input--build--js--utils.js.js" # @23.3.2
pin "stimulus-places-autocomplete" # @0.5.0
pin "@googlemaps/js-api-loader", to: "@googlemaps--js-api-loader.js" # @1.16.6
