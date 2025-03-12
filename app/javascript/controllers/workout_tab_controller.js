import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab"]

  connect() {
    this.element.addEventListener("turbo:frame-load", this.handleFrameLoad)
    this.showActiveTab()
  }

  disconnect() {
    this.element.removeEventListener("turbo:frame-load", this.handleFrameLoad)
  }

  handleFrameLoad = (event) => {
    const frame = event.target
    const newURL = frame.src

    history.pushState({}, "", newURL)

    this.showActiveTab()
  }

  showActiveTab() {
    const urlParams = new URLSearchParams(window.location.search)
    const currentTab = urlParams.get("tab") || "completed"

    this.tabTargets.forEach(link => {
      const innerDiv = link.querySelector("div")
      if (!innerDiv) {
        return
      }

      if (link.href.includes(`tab=${currentTab}`)) {
        innerDiv.classList.add("active")
      } else {
        innerDiv.classList.remove("active")
      }
    })
  }
}
