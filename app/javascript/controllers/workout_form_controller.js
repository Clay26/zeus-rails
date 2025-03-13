import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["exercises", "exerciseTemplate", "exerciseSets", "setTemplate"]

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
}
