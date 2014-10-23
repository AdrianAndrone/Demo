class AddStateToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :state, :string
  end
end
