import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {

  static values = {
    apiKey: String,
    markers: Array
  }


    connect() {

      console.log('connected');
      mapboxgl.accessToken = this.apiKeyValue

      this.map = new mapboxgl.Map({
        container: this.element,
        style: "mapbox://styles/mapbox/streets-v10"
      })

      this.#addMarkersToMap()
      this.#setDefaultMapBounds()

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


      // Default to Aldgate London as the map location in case browser geolocation API access is denied
    #setDefaultMapBounds() {
      const aldgateBounds = new mapboxgl.LngLatBounds()
        .extend([-0.07583, 51.51376])
        .extend([-0.05986, 51.51859]);

      this.map.fitBounds(aldgateBounds, {
        padding: 70,
        maxZoom: 13,
        duration: 0,
      });
    }

 }
