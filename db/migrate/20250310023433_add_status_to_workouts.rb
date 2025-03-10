class AddStatusToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :status, :integer, default: 0, null: false
  end
end
