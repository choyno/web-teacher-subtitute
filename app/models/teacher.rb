class Teacher < ActiveRecord::Base
  
  attr_accessible :firstname, :lastname
  
  has_many :subtitutes
  has_many :teacher_subjects
  
  has_many :subjects, through: :teacher_subjects
  
  validates :lastname, :firstname, presence: true
  
end
