import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab"]

  connect() {
    this.showActiveTab("completed")
  }

  update(event) {
    const button = event.currentTarget

    const selectedTab = button.dataset.tab

    this.showActiveTab(selectedTab)
  }

  showActiveTab(selectedTab) {
    this.tabTargets.forEach(tab => {
      const innerDiv = tab.querySelector("div")
      if (!innerDiv) {
        return
      }

      if (tab.dataset.tab === selectedTab) {
        innerDiv.classList.add("active")
      } else {
        innerDiv.classList.remove("active")
      }
    })
  }
}
