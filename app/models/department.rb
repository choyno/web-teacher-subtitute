class Department < ActiveRecord::Base


	scope :search_by_name, lambda { | value | where("CONCAT(name) LIKE?", "%#{value}%") }

	validates :name , presence: true, uniqueness: { case_sensitivity: true }


	def self.search(search)

		department_scope = self.scoped({})

		department_scope = department_scope.search_by_name(search) if search.present?

		return department_scope
	
	end

end