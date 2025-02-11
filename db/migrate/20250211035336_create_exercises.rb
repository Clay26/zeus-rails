class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
