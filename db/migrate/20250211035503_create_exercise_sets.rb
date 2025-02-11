class CreateExerciseSets < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_sets do |t|
      t.references :workout_exercise, null: false, foreign_key: true
      t.integer :reps
      t.decimal :weight
      t.integer :set_number
      t.text :notes

      t.timestamps
    end
  end
end
