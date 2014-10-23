class Course < ActiveRecord::Base
  attr_accessible :description, :name, :owner, :year, :course_id, :vcode
  #validates :name, presence: true, uniqueness: false
  validates :vcode, presence: true
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :documents, dependent: :destroy
  attr_accessible :file
  has_attached_file :file
  validates_attachment_content_type :file, content_type: ['application/pdf', 'application/msword']
  validates :year, inclusion: {in: 1..4}
  validates :name, presence: true

  scope :first_year, where(:year=> 1)
  scope :second_year, where(:year=>2)
  scope :third_year, where(:year=>3)
  scope :last_year, where(:year=>4)


  max_paginates_per 2

  def add_vcode(user)
    self.vcode=user.profile.vcode
    self.save
  end

  # def self.search (search)
  #   unless search.nil?
  #     where('name LIKE ?', "#{search}")
  #   end
  # end

  searchable do
    text :name
  end



  # def self.filter_by(scope)
  #   Course.scope
  # end


  # searchable do
  #   text :name, :owner
  # end

end


