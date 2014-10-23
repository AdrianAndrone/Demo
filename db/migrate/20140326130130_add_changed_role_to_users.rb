class AddChangedRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :changed_role, :boolean
  end
end
