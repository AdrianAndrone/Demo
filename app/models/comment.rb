class Comment < ActiveRecord::Base
  attr_accessible :description, :subject, :announcement_id, :user_id
  belongs_to :announcement
  belongs_to :user
  validates_length_of :description, minimum:1, maximum:160, allow_black: true
end

