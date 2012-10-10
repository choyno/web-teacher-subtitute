class Teacher < ActiveRecord::Base
  
  scope :search_by_name, lambda { |value| where("CONCAT(firstname,' ', lastname) LIKE ?", "%#{value}%") }


  
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



  def self.search(search)

    teacher_scope = self.scoped({})

    teacher_scope = teacher_scope.search_by_name(search) if search.present?
    
    return teacher_scope
  end


end
