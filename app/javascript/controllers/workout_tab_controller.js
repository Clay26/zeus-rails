import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:frame-load", this.handleFrameLoad)
  }

  disconnect() {
    this.element.removeEventListener("turbo:frame-load", this.handleFrameLoad)
  }

  handleFrameLoad = (event) => {
    const frame = event.target
    const newURL = frame.src

    history.pushState({}, "", newURL)
  }
}
