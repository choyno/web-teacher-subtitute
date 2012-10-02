class Room < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, presence: true
  has_many :teacher_subjects
end
