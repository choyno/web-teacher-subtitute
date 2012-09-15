class Subject < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_many :teacher_subjects

  validates :code, :name, presence: true
  
end
