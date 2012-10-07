class SubjectType < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :teacher_subjects
  validates :name, presence: true

scope :search_by_name, lambda { | value| where("CONCAT(name ) Like ?", "%#{value}%")}

def self.search(search)
	subject_type_scope = self.scoped({})

	subject_type_scope = subject_type_scope.search_by_name(search) if search.present?

	return subject_type_scope
end

end
