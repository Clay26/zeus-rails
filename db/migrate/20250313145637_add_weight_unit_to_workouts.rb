class AddWeightUnitToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :weight_unit, :string, default: "lbs"
  end
end
