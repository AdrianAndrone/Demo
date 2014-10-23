class RemoveBirthdayFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :birthday
  end

  def down
    add_column :profiles, :birthday, :date
  end
end
