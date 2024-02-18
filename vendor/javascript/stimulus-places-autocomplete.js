import { Controller as t } from "@hotwired/stimulus";
class src_default extends t {
  initialize() {
    this.placeChanged = this.placeChanged.bind(this);
  }
  connect() {
    "undefined" !== typeof google && this.initAutocomplete();
  }
  initAutocomplete() {
    this.autocomplete = new google.maps.places.Autocomplete(
      this.addressTarget,
      this.autocompleteOptions,
    );
    this.autocomplete.addListener("place_changed", this.placeChanged);
  }
  placeChanged() {
    this.place = this.autocomplete.getPlace();
    const t = this.place.address_components;
    if (void 0 !== t) {
      const e = this.formatAddressComponents(t);
      this.setAddressComponents(e);
    }
    void 0 !== this.place.geometry && this.setGeometry(this.place.geometry);
  }
  setAddressComponents(t) {
    this.hasStreetNumberTarget &&
      (this.streetNumberTarget.value = t.street_number || "");
    this.hasRouteTarget && (this.routeTarget.value = t.route || "");
    this.hasCityTarget && (this.cityTarget.value = t.locality || "");
    this.hasCountyTarget &&
      (this.countyTarget.value = t.administrative_area_level_2 || "");
    this.hasStateTarget &&
      (this.stateTarget.value = t.administrative_area_level_1 || "");
    this.hasCountryTarget && (this.countryTarget.value = t.country || "");
    this.hasPostalCodeTarget &&
      (this.postalCodeTarget.value = t.postal_code || "");
  }
  setGeometry(t) {
    this.hasLongitudeTarget &&
      (this.longitudeTarget.value = t.location.lng().toString());
    this.hasLatitudeTarget &&
      (this.latitudeTarget.value = t.location.lat().toString());
  }
  get autocompleteOptions() {
    return {
      fields: ["address_components", "geometry"],
      componentRestrictions: { country: this.countryValue },
    };
  }
  preventSubmit(t) {
    "Enter" === t.code && t.preventDefault();
  }
  formatAddressComponents(t) {
    const e = {};
    t.forEach((t) => {
      const s = t.types[0];
      e[s] = t.long_name;
    });
    return e;
  }
}
src_default.targets = [
  "address",
  "city",
  "streetNumber",
  "route",
  "postalCode",
  "country",
  "county",
  "state",
  "longitude",
  "latitude",
];
src_default.values = { country: Array };
export { src_default as default };
