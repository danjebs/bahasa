class CreateLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :languages do |t|
      t.string :code, null: false, default: ""
      t.string :name, null: false, default: ""
      t.timestamps
    end
  end
end
