class AddTakenToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :taken, :boolean, :default=> false
  end
end
