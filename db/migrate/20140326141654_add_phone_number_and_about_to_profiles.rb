class AddPhoneNumberAndAboutToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :phone_number, :string
    add_column :profiles, :about, :string
  end
end
