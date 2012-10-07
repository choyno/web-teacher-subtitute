class DayCode < ActiveRecord::Base


  scope :search_by_name, lambda { | value | where("CONCAT(name) LIKE?", "%#{value}%")}

  validates :name, presence: true
  
  def self.search(search)

		day_code_scope = self.scoped({})

		day_code_scope = day_code_scope.search_by_name(search) if search.present?

		return day_code_scope  	
  end

end
