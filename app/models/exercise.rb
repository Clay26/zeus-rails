class Exercise < ApplicationRecord
  include ExerciseCategories

  has_many :workout_exercises
  has_many :workouts, through: :workout_exercises

  # Presence validations
  validates :name, presence: true
  validates :category, presence: true

  # Length validations
  validates :name, length: { minimum: 2, maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  # Format validations
  validates :name, uniqueness: { case_sensitive: false }

  # Category validation
  validates :category, inclusion: {
    in: EXERCISE_CATEGORIES,
    message: "%{value} is not a valid category"
  }

  # Custom cleanup
  before_save :capitalize_name

  private

  def capitalize_name
    self.name = name.titleize if name.present?
  end
end
