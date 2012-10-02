class SubjectType < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :teacher_subjects
  validates :name, presence: true

end
