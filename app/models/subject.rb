class Subject < ActiveRecord::Base
    
  has_many :teacher_subjects

  validates :code, :name, presence: true, uniqueness: { case_sensitivity: true }


  def subjectinfo
    "#{self.code}  #{self.name}"
  end
  
  scope :search_by_name, lambda { | value| where("CONCAT(name, ' ' , code ) Like ?", "%#{value}%")}

  def self.search(search)
  	subject_scope = self.scoped({})

  	subject_scope = subject_scope.search_by_name(search) if search.present?

  	return subject_scope
  end


end
