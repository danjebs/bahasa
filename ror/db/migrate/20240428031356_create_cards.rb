class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :type
      t.string :front
      t.string :back
      t.integer :position
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
