class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :title
      t.string :type
      t.integer :position

      t.timestamps
    end
  end
end
