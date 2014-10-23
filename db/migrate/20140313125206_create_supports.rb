class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.string :email
      t.string :sender_name
      t.string :support_type
      t.string :content

      t.timestamps
    end
  end
end
