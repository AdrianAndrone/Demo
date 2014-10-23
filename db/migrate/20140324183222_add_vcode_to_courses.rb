class AddVcodeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :vcode, :string
  end
end
