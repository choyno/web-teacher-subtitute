class Teacher < ActiveRecord::Base
    
  has_many :subtitutes
  has_many :teacher_subjects
  
  has_many :subjects, through: :teacher_subjects
  
  validates :lastname, :firstname, presence: true
  validates :phone_number, :length => {:minimum => 6, :maximum => 25},
  						   :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i },
  						   :allow_blank => true,
  						    uniqueness: { case_sensitivity: true }


  def fullname
    " #{self.lastname} #{self.firstname}"
  end



  def self.search(search)
    if search
      where('firstname LIKE ?', "%#{search}%") 
    else
      find(:all)
    end
  end

end
