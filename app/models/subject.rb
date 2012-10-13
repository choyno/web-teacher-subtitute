class Subject < ActiveRecord::Base
    
  has_many :teacher_subjects

  validates :code, :name, presence: true, uniqueness: { case_sensitivity: true }


  def subjectinfo
    "#{self.code}  #{self.name}"
  end
  
  scope :search_by_name, lambda { | value| where("CONCAT(name) Like ?", "%#{value}%")}
  scope :search_by_code, lambda { | value| where("CONCAT(code) Like ?", "%#{value}%")}

  def self.search(searc_by, search)
  	subject_scope = self.scoped({})
    case 
    when 'Subject Code'
  	 subject_scope = subject_scope.search_by_code(search) 
    when 'Subject Name'
      subject_scope = subject_scope.search_by_name(search) 
    end
  	return subject_scope
  end


end
