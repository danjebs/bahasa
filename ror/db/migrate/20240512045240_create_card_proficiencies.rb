class CreateCardProficiencies < ActiveRecord::Migration[7.1]
  def change
    create_table :card_proficiencies do |t|
      t.references :journey, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
