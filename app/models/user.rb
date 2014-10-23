require 'state_machine'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :state, :changed_role
  #validates :email, presence: true, uniqueness: false
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :announcements
  has_many :comments
  has_one :profile
  after_create :default_role
  ROLES = %w[admin teacher student]

  def default_role
    self.role='student'
    self.save
  end

  # state_machine :state, initial: :accepted do

  #   after_transition :on => :suspend, :do => :drop

  #   event :suspend do
  #     transition :pending=> :suspended
  #   end

  #   event :approve do


  # end
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

  def change_role
    self.changed_role= true
  end

  def drop
    self.delete
  end

  def admin?
    return true if self.role=='admin'
  end

  def teacher?
    return (self.role=='teacher')? true : false
  end

  def student?
    return (self.role=='student')? true : false
  end


end
