class AddAnnouncementIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :announcement_id, :integer
  end
end
