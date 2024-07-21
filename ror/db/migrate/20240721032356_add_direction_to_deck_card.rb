class AddDirectionToDeckCard < ActiveRecord::Migration[7.1]
  def change
    execute <<-SQL
      CREATE TYPE deck_card_direction AS ENUM ('to_base', 'from_base');
    SQL

    add_column :deck_cards, :direction, :deck_card_direction, default: "from_base", null: false
  end
end
