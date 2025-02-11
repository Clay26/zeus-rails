class CreateWorkouts < ActiveRecord::Migration[8.0]
  def change
    create_table :workouts do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
