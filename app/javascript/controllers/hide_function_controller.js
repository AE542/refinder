import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hide-function"
export default class extends Controller {
  static targets = ["element", "button"]

  connect() {
    console.log("test1")

  }

  hide() {
    // toggles the element -the map- to be hidden from view

    //adding fade effect when button is pressed

    if (document.getElementsByClassName('mapContainer')[0]) {
      const mapContainer = document.getElementsByClassName('mapContainer')[0]
      console.log(document.getElementsByClassName('mapContainer'))
      if (mapContainer.style.visibility == 'hidden') {
        mapContainer.style.visibility = 'visible';
        mapContainer.style.opacity = '1'
        mapContainer.style.height = '600px';
      } else {
        mapContainer.style.visibility = 'hidden';
        mapContainer.style.opacity = '0';
        mapContainer.style.height = '0';
      }
    }
    //this.elementTarget.classList.toggle("d-none")
  // terniary ensures button displays correct text
    this.buttonTarget.innerText = this.buttonTarget.innerText == "Show Map" ? "Hide Map" : "Show Map"

  }
}
