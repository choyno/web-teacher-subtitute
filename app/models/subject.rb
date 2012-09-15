class Subject < ActiveRecord::Base
    
  has_many :teacher_subjects

  validates :code, :name, presence: true
  
end
