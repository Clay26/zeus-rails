class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise
  has_many :exercise_sets
  accepts_nested_attributes_for :exercise_sets, allow_destroy: true
end
