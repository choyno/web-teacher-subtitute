class Reason < ActiveRecord::Base

	scope :search_by_name, lambda { | value | where("CONCAT(name) LIKE ?", "%#{value}%")}

	validates :name, presence: true

def self.search(search)

	reason_scope = self.scoped({})

	reason_scope = reason_scope.search_by_name(search) if search.present?

	return reason_scope
end
end
