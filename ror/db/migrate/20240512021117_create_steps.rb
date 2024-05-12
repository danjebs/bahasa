class CreateSteps < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE step_status AS ENUM ('created', 'started', 'completed');
    SQL

    create_table :steps do |t|
      t.references :journey, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end

    add_column :steps, :status, :step_status
  end

  def down
    drop_table :steps

    execute <<-SQL
      DROP TYPE step_status;
    SQL
  end
end
