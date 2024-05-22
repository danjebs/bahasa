class CreateDeckCards < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE deck_card_status AS ENUM ('created', 'attempted', 'completed');
    SQL

    execute <<-SQL
      CREATE TYPE deck_card_outcome AS ENUM ('none', 'hint', 'flash', 'fail');
    SQL


    create_table :deck_cards do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.integer :position
      t.integer :time_taken
      t.integer :score

      t.timestamps
    end

    add_column :deck_cards, :status, :deck_card_status
    add_column :deck_cards, :outcome, :deck_card_outcome
  end

  def down
    drop_table :deck_cards

    execute <<-SQL
      DROP TYPE deck_card_status;
      DROP TYPE deck_card_outcome;
    SQL
  end
end
