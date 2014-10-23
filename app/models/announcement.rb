class Announcement < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  scope :desc, order("announcements.created_at DESC")
end
