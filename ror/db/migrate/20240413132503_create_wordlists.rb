class CreateWordlists < ActiveRecord::Migration[7.1]
  def change
    create_table :wordlists do |t|
      t.string :name
      t.string :slug
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
