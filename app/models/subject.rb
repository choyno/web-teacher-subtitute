class Subject < ActiveRecord::Base
    
  has_many :teacher_subjects

  validates :code, :name, presence: true, uniqueness: { case_sensitivity: true }


  def subjectinfo
    "#{self.code}  #{self.name}"
  end
  
end
