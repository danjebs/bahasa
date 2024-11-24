class RemoveRoleFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :role

    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
