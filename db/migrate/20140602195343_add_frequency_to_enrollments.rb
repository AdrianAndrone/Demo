class AddFrequencyToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :frequency, :integer
  end
end
