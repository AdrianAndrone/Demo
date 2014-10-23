class AddVcodeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :vcode, :string
  end
end
