class Teacher < ActiveRecord::Base
    
  has_many :subtitutes
  has_many :teacher_subjects
  
  has_many :subjects, through: :teacher_subjects
  
  validates :lastname, :firstname, presence: true
  
end
