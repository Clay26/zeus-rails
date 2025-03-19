import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filter", "formField"]

  connect() {
    const defaultValue = this.element.dataset.default || null;
    const paramKey = this.element.dataset.param;

    if (defaultValue === null || defaultValue.trim() === "") {
      console.error("ERROR: [filter_controller] Missing or empty data-default value.");
    }

    let selectedFilter = defaultValue;

    if (paramKey) {
      const urlParams = new URLSearchParams(window.location.search);
      selectedFilter = (urlParams.get(paramKey) || defaultValue).toLowerCase();
    }

    this.showActiveFilter(selectedFilter);
    this.updateField(selectedFilter);
  }

  update(event) {
    const button = event.currentTarget;

    const selectedFilter = button.dataset.name;

    this.showActiveFilter(selectedFilter);
    this.updateField(selectedFilter);
  }

  showActiveFilter(selectedFilter) {
    this.filterTargets.forEach(filter => {
      if (filter.dataset.name === selectedFilter) {
        filter.classList.add("active");
      } else {
        filter.classList.remove("active");
      }
    })
  }

  updateField(selectedFilter) {
    if (this.hasFormFieldTarget) {
      this.formFieldTarget.value = selectedFilter;
    }
  }
}
