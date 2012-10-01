class Section < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :teacher_subjects
end
