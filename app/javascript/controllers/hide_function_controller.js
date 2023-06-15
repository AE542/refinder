import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hide-function"
export default class extends Controller {
  static targets = ["element", "button"]

  connect() {
    console.log("test1")

  }

  hide() {
    // toggles the element -the map- to be hidden from view
    this.elementTarget.classList.toggle("d-none")
  // terniary ensures button displays correct text
    this.buttonTarget.innerText = this.buttonTarget.innerText == "Show Map" ? "Hide Map" : "Show Map"
  }
}
