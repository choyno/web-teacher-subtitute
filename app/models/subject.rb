class Subject < ActiveRecord::Base
  
  attr_accessible :code, :name
  
  has_many :teacher_subjects

  validates :code, :name, presence: true
  
end
