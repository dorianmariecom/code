# frozen_string_literal: true

pin "application"
pin "i18n"
pin "debounce"
pin "constants"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "intl-tel-input", to: "intl-tel-input.js"
pin "intl-tel-input/build/js/utils", to: "intl-tel-input--build--js--utils.js"
pin "stimulus-places-autocomplete"
pin "@googlemaps/js-api-loader", to: "@googlemaps--js-api-loader.js"
