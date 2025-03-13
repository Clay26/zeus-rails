import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["exercises", "exerciseTemplate", "exerciseSets", "setTemplate", "toggle", "unitField"]

  connect() {
    this.showSelectedUnit()
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
  }

  removeExerciseSetFromTemplate(event) {
    event.preventDefault()
    const wrapper = event.currentTarget.closest(".exercise-set-fields")
    wrapper.remove()
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
}
