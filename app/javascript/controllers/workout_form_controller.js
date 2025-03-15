import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["exercises", "exerciseTemplate", "exerciseSets", "exerciseSetRow", "setTemplate", "toggle", "unitField", "hiddenTest"]

  connect() {
    this.showSelectedUnit()
    this.updateSetNumbers()
  }

  addExerciseToTemplate(event) {
    event.preventDefault()

    const content = this.exerciseTemplateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.exercisesTarget.insertAdjacentHTML("beforeend", content)
  }

  removeExerciseFromTemplate(event) {
    event.preventDefault()
    const wrapper = event.currentTarget.closest(".workout-exercise-fields")
    wrapper.remove()
  }

  addExerciseSetToTemplate(event) {
    event.preventDefault()

    const content = this.setTemplateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.exerciseSetsTarget.insertAdjacentHTML("beforeend", content)

    this.updateSetNumbers()
  }

  removeExerciseSetFromTemplate(event) {
    event.preventDefault()
    const wrapper = event.currentTarget.closest(".exercise-set-fields")
    wrapper.remove()

    this.updateSetNumbers()
  }

  toggleUnit(event) {
    event.preventDefault()

    this.toggleTargets.forEach((button) => button.classList.remove("active"))
    event.currentTarget.classList.add("active")

    this.unitFieldTarget.value = event.currentTarget.innerText.trim().toLowerCase()
  }

  showSelectedUnit() {
    const selectedUnit = this.unitFieldTarget.value

    this.toggleTargets.forEach((button) => {
      if (button.dataset.unit == selectedUnit) {
        button.classList.add("active")
      } else {
        button.classList.remove("active")
      }
    });
  }

  updateSetNumbers() {
    const exerciseSetRows = this.exerciseSetRowTargets

    exerciseSetRows.forEach((row, idx) => {
      const setNumber = idx + 1

      const visibleSetNumber = row.querySelector('.visible-set-number')
      if (visibleSetNumber) {
        visibleSetNumber.textContent = setNumber
      }

      const hiddenSetNumber = row.querySelector('.hidden-set-number')
      if (hiddenSetNumber) {
        hiddenSetNumber.value = setNumber
      }
    })
  }
}
