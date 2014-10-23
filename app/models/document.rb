class Document < ActiveRecord::Base
  attr_accessible :name, :course_id
  belongs_to :course
  attr_accessible :file
  has_attached_file :file
  validates_attachment_content_type :file, content_type: ['application/pdf', 'application/msword']
  validates :file, :presence => true
end
