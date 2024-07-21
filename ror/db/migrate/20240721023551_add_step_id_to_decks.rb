class AddStepIdToDecks < ActiveRecord::Migration[7.1]
  def change
    add_reference :decks, :step, null: true, foreign_key: true

    remove_column :decks, :difficulty
    remove_column :decks, :duration
  end
end
