class Status < ActiveRecord::Base

	validates :name, presence: true , uniqueness: { case_sensitivity: true }
end
