class CreatePhrases < ActiveRecord::Migration[7.1]
  def change
    create_table :phrases do |t|
      t.references :exercise, null: false, foreign_key: true
      t.string :phrase
      t.string :translation
      t.integer :position

      t.timestamps
    end
  end
end
