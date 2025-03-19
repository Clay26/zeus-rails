import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["exercises", "exerciseTemplate", "exerciseSetTable", "exerciseSetRow", "setTemplate", "toggle", "unitField", "weightUnitDisplay"]

  connect() {
    this.showSelectedUnit()
    this.updateAllSetNumbers()
  }

  addExerciseToTemplate(event) {
    event.preventDefault()

    const button = event.currentTarget;
    const exerciseId = button.dataset.exerciseId;
    const exerciseName = button.dataset.exerciseName;

    let content;
    content = this.exerciseTemplateTarget.innerHTML.replace(/NEW_EXERCISE/g, new Date().getTime())
    content = content.replace(/EXERCISE_ID/g, exerciseId)
    content = content.replace(/EXERCISE_NAME/g, exerciseName)
    console.log(content)
    this.exercisesTarget.insertAdjacentHTML("beforeend", content)
  }

  removeExerciseFromTemplate(event) {
    event.preventDefault()
    const wrapper = event.currentTarget.closest(".workout-exercise-fields")
    wrapper.remove()
  }

  addExerciseSetToTemplate(event) {
    event.preventDefault()

    const button = event.currentTarget;

    const exerciseParent = button.closest(".workout-exercise-fields")

    if (!exerciseParent) {
      console.error("Unable to find exercise to add set to.")
      return;
    }

    const exerciseSetTableParent = exerciseParent.querySelector('[data-workout-form-target="exerciseSetTable"]')

    if (!exerciseSetTableParent) {
      console.error("Unable to find exercise sets parent to add set to.")
      return;
    }

    const content = button.dataset.fields.replace(/NEW_SET/g, new Date().getTime())

    exerciseSetTableParent.insertAdjacentHTML("beforeend", content)

    this.showSelectedUnit()
    this.updateSetNumbersForTable(exerciseSetTableParent)
  }

  removeExerciseSetFromTemplate(event) {
    event.preventDefault()
    const row = event.currentTarget.closest(".exercise-set-fields")
    const destroyField = row.querySelector('[data-workout-form-target="destroyField"]')
    const setTable = row.closest('[data-workout-form-target="exerciseSetTable"]')

    if (row.dataset.newRecord === 'true') {
      row.remove();
    } else if (destroyField) {
      destroyField.value = true
      row.style.display = "none"
    }

    this.updateSetNumbersForTable(setTable)
  }

  toggleUnit(event) {
    event.preventDefault()

    const selectedWeightUnit = event.currentTarget.innerText.trim().toLowerCase()

    this.toggleTargets.forEach((button) => button.classList.remove("active"))
    event.currentTarget.classList.add("active")

    this.unitFieldTarget.value = selectedWeightUnit

    this.weightUnitDisplayTargets.forEach((cell) => cell.innerText = selectedWeightUnit)
  }

  showSelectedUnit() {
    const selectedWeightUnit = this.unitFieldTarget.value

    this.toggleTargets.forEach((button) => {
      if (button.dataset.unit == selectedWeightUnit) {
        button.classList.add("active")
      } else {
        button.classList.remove("active")
      }
    });

    this.weightUnitDisplayTargets.forEach((cell) => cell.innerText = selectedWeightUnit)
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
