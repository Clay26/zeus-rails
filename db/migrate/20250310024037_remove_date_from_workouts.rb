class RemoveDateFromWorkouts < ActiveRecord::Migration[8.0]
  def change
    remove_column :workouts, :date, :datetime
  end
end
