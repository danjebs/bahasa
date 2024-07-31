class AddCardTypesToDeck < ActiveRecord::Migration[7.1]
  def change
    execute <<-SQL
      CREATE TYPE deck_difficulties AS ENUM ('mixed', 'easy', 'medium', 'hard', 'ultra');
    SQL

    add_column :decks, :difficulty, :deck_difficulties, default: "mixed", null: false
  end
end
