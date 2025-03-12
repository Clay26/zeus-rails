import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  navigate(event) {
    window.location = this.urlValue
  }

  stop(event) {
    event.stopPropagation()
  }
}
