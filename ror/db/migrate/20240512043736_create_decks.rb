class CreateDecks < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE deck_status AS ENUM ('created', 'started', 'completed');
    SQL

    create_table :decks do |t|
      t.references :journey, null: false, foreign_key: true
      t.integer :difficulty
      t.integer :duration

      t.timestamps
    end

    add_column :decks, :status, :deck_status
  end

  def down
    drop_table :decks

    execute <<-SQL
      DROP TYPE deck_status;
    SQL
  end
end
