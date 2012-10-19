class Room < ActiveRecord::Base

  # attr_accessible :title, :body


  scope :search_by_name, lambda { | value | where("CONCAT(name) LIKE ?", "%#{value}%") }

  validates :name, presence: true
  has_many :teacher_subjects

  def self.search(search)

  	room_scope = self.scoped({})

  	room_scope = room_scope.search_by_name(search) if search.present?

  	return room_scope
  end



end
