# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('student', 'teacher', 'admin');
    SQL

    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :name,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_column :users, :role, :user_role

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def down
    drop_table :users

    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
