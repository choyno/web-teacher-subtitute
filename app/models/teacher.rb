class Teacher < ActiveRecord::Base
  
 
  scope :search_by_firstname, lambda { |value| where("firstname LIKE ?", "%#{value}%") }
  scope :search_by_lastname, lambda { |value| where("lastname LIKE ?", "%#{value}%") }
  scope :search_by_phone, lambda { |value| where("phone_number LIKE ?", "%#{value}%") }
  
  has_many :teacher_subjects
  has_many :substitutes, through: :teacher_subjects


  has_many :subjects, through: :teacher_subjects
  
  validates :lastname, :firstname, presence: true
  validates :phone_number, :length => {:minimum => 6, :maximum => 25},
  						   :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i },
  						   :allow_blank => true,
  						    uniqueness: { case_sensitivity: true }


  def fullname
    " #{self.lastname} #{self.firstname}"
  end

  def self.search(search_by, search)

    teacher_scope = self.scoped({})

    case search_by
        when 'Firstname'
           teacher_scope = teacher_scope.search_by_firstname(search)
        when 'Lastname'
            teacher_scope = teacher_scope.search_by_lastname(search)
        when 'Phone Number'
            teacher_scope = teacher_scope.search_by_phone(search)
        end
    return teacher_scope


  end


end
