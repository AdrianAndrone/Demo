class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.string :address
      t.string :email
      t.string :gender

      t.timestamps
    end
  end
end
