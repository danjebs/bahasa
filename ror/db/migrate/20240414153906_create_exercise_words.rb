class CreateExerciseWords < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_words do |t|
      t.references :exercise, null: false, foreign_key: true
      t.string :word
      t.string :translation
      t.integer :position

      t.timestamps
    end
  end
end
