class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false, default: ""
      t.string :slug, null: false, default: ""
      t.references :language, index: true, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
