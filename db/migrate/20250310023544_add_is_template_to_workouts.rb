class AddIsTemplateToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :is_template, :boolean, default: false, null: false
  end
end
