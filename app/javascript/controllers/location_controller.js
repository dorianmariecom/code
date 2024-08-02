import PlacesAutocomplete from "stimulus-places-autocomplete";
import { Loader } from "@googlemaps/js-api-loader";

const loader = new Loader({
  apiKey: window.GOOGLE_MAPS_API_KEY,
  version: "weekly",
  libraries: ["places"],
});

export default class extends PlacesAutocomplete {
  static targets = [
    "input",
    "city",
    "streetNumber",
    "route",
    "state",
    "postalCode",
    "country",
    "latitude",
    "longitude",
  ];

  connect() {
    loader.load().then((google) => {
      this.autocomplete = new google.maps.places.Autocomplete(
        this.inputTarget,
        this.autocompleteOptions,
      );
      this.autocomplete.addListener("place_changed", this.placeChanged);
    });
  }
}
