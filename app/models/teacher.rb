class Teacher < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_many :subtitutes
  has_many :teacher_subjects
  
  has_many :subjects, through: :teacher_subjects
  
  validates :last_name, :first_name, presence: true
  
end
