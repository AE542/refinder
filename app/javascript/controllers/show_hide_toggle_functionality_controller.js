import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-hide-toggle-functionality"
export default class extends Controller {
    static targets = ["hide-map"]

  connect() {
    console.log("working")
  }
 }

 // currently not working 
