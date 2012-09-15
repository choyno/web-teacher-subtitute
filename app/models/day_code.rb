class DayCode < ActiveRecord::Base
  # attr_accessible :title, :body
  
  validates :name, prensence: true
  
end
