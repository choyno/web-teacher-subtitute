class DayCode < ActiveRecord::Base


  scope :search_by_name, lambda { | value | where("CONCAT(name) LIKE?", "%#{value}%")}

  validates :name, presence: true
  
  def self.search(search)

		day_code_scope = self.scoped({})

		day_code_scope = day_code_scope.search_by_name(search) if search.present?

		return day_code_scope  	
  end
  
  
  def self.day_name_shortcut(dayname)
    
    return case dayname
      when 'Mon'; 'M'
      when 'Tue'; 'T'
      when 'Wed'; 'W'
      when 'Thu'; 'TH'
      when 'Fri'; 'F'
      when 'Sat'; 'SA'
      when 'Sun'; 'S'
    end
    
  end
  
end
