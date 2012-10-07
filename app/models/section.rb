class Section < ActiveRecord::Base
  # attr_accessible :title, :body
  scope :search_by_name, lambda { | value | where("CONCAT(name) LIKE ? ", "%#{value}")}
  validates :name, presence: true
  has_many :teacher_subjects

  def self.search(search)

  	section_scope = self.scoped({})

  	section_scope = section_scope.search_by_name(search) if search.present?

  	return section_scope
  end

end
