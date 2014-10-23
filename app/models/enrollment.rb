require 'state_machine'
class Enrollment < ActiveRecord::Base
  attr_accessible :course_id, :user_id, :state, :taken, :frequency
  belongs_to :user
  belongs_to :course

  validates :frequency, numericality: { :less_than_or_equal_to=> 3 }

  # validates_uniqueness_of :course_id, :if :state
  #validates_uniqueness_of :user_id
  # before_save :default_state
  # def default_state
  #   self.state= :pending
  # end

  #scope :by_user, where(:course_id=> Course.find(params[:course_id]))

  scope :aproved_collection, where(:state=>'accepted')

  state_machine :state, initial: :pending do

    event :approve do
      transition :pending=> :accepted, :rejected=>:accepted
    end

    event :reject do
      transition :pending=> :rejected, :accepted=>:rejected, on: :drop
    end

    event :suspend do
      transition :accepted => :suspended, on: :drop
    end

  end

  # def state
  #   self.state= 'pending'
  # end

  def drop
    self.delete
  end

  def is_accepted?
    return true if self.state=='accepted'
  end

  def change_taken_attributes
    self.taken = true
    self.save
  end

  def increment(attribute , by)
    self[attribute] ||= 0;
    self[attribute] += by
    self
  end



  # def aprove!
  #   self.state = :approved
  #   self.save
  # end

  # def reject!
  #   self.state = :reject
  #   self.save
  # end

end
