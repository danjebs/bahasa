class AddDefaultLanguageToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :default_language, null: true, foreign_key: { to_table: :languages }
  end
end
