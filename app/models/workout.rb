class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_exercises, dependent: :destroy
  accepts_nested_attributes_for :workout_exercises, allow_destroy: true
  has_many :exercises, through: :workout_exercises

  enum :status, { draft: 0, in_progress: 1, completed: 2, cancelled: 3 }

  validates :name, presence: true, length: { in: 2..100 }
  validates :is_template, inclusion: { in: [true, false] }
  validates :started_at, presence: true, unless: :is_template?
  validates :ended_at, comparison: { greater_than: :started_at }, if: -> { started_at.present? && ended_at.present? }
end
