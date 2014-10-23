class Profile < ActiveRecord::Base
  attr_accessible :email, :firstname, :gender, :lastname, :user_id, :avatar, :vcode, :about, :phone_number
  belongs_to :user
  has_attached_file :avatar, :default_url => "rails.png"
  validates_attachment_content_type :avatar, :content_type => /^image\/(png|gif|jpeg)/, :message => 'only (png/gif/jpeg) images'
  #validates_presence_of :avatar
end






