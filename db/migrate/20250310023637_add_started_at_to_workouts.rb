class AddStartedAtToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :started_at, :datetime
  end
end
