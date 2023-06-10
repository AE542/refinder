import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showmap"
export default class extends Controller {

  static values = {
    apiKey: String,
    markers: Array,
    marker: Object
  }


    connect() {

      console.log('connected');
      mapboxgl.accessToken = this.apiKeyValue

      this.map = new mapboxgl.Map({
        container: this.element,
        style: "mapbox://styles/mapbox/streets-v10",
        center: [this.markerValue.lng, this.markerValue.lat],
        zoom: 12
      })

      this.#addMarkersToMap()
      this.addMarkerToMap();

    }

    #addMarkersToMap() {
      this.markersValue.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
        const customMarker = document.createElement("div");
        customMarker.innerHTML = marker.marker_html;

        new mapboxgl.Marker(customMarker)
          .setLngLat([marker.lng, marker.lat])
          .setPopup(popup)
          .addTo(this.map);
      });
    }


    addMarkerToMap() {
      const marker = this.markerValue;
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    }

 }
