import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["exercises", "exerciseTemplate", "exerciseSetTable", "exerciseSetRow", "setTemplate", "toggle", "unitField", "hiddenTest"]

  connect() {
    this.showSelectedUnit()
    this.updateAllSetNumbers()
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

    const exerciseParent = event.currentTarget.closest(".workout-exercise-fields")

    if (!exerciseParent) {
      console.error("Unable to find exercise to add set to.")
      return;
    }

    const exerciseSetTableParent = exerciseParent.querySelector('[data-workout-form-target="exerciseSetTable"]')

    if (!exerciseSetTableParent) {
      console.error("Unable to find exercise sets parent to add set to.")
      return;
    }

    const content = this.setTemplateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    exerciseSetTableParent.insertAdjacentHTML("beforeend", content)

    this.updateSetNumbersForTable(exerciseSetTableParent)
  }

  removeExerciseSetFromTemplate(event) {
    event.preventDefault()
    const row = event.currentTarget.closest(".exercise-set-fields")
    const destroyField = row.querySelector('[data-workout-form-target="destroyField"]')
    const setTable = row.closest('[data-workout-form-target="exerciseSetTable"]')

    destroyField.value = true
    row.style.display = "none"

    this.updateSetNumbersForTable(setTable)
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

  updateAllSetNumbers() {
    const exerciseSetTables = this.exerciseSetTableTargets

    exerciseSetTables.forEach((table) => {
      this.updateSetNumbersForTable(table)
    })
  }

  updateSetNumbersForTable(setTable) {
    if (!setTable) {
      console.error("Exercise set table is null.")
      return;
    }

    const allExerciseSets = setTable.querySelectorAll(".exercise-set-fields")
    const visibleExerciseSets = Array.from(allExerciseSets).filter(
      (row) => row.style.display !== "none"
    )

    visibleExerciseSets.forEach((set, idx) => {
      const setNumber = idx + 1
      const visibleSetNumber = set.querySelector('.visible-set-number')
      if (visibleSetNumber) {
        visibleSetNumber.textContent = setNumber
      }

      const hiddenSetNumber = set.querySelector('.hidden-set-number')
      if (hiddenSetNumber) {
        hiddenSetNumber.value = setNumber
      }
    })
  }
}
