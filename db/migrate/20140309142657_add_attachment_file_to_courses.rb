class AddAttachmentFileToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :courses, :file
  end
end
