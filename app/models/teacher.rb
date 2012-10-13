class Teacher < ActiveRecord::Base
  

  scope :search_by_name, lambda { |value| where("CONCAT(firstname,' ', lastname) LIKE ?", "%#{value}%") }

  scope :search_by_firstname, lambda { | value | where("firstname LIKE ?", "%#{value}%") }

  scope :search_by_lastname, lambda { | value | where("lastname LIKE ?", "%#{value}%")}

  scope :search_by_phone, lambda { | value | where("phone_number LIKE ?" , "%#{value}%")}


 
  has_many :teacher_subjects
  has_many :substitutes, through: :teacher_subjects

  has_many :availabilities, class_name: :TeacherAvailability

  has_many :subjects, through: :teacher_subjects
  
  validates :lastname, :firstname, presence: true
  validates :phone_number, :length => {:minimum => 6, :maximum => 25},
  						   :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i },
  						   :allow_blank => true,
  						    uniqueness: { case_sensitivity: true }


  def fullname
    " #{self.lastname} #{self.firstname}"
  end

  def generate_availability
    # fetch all teacher schedules
    # loop each time schedules and plot if its available or not
    # loop for each M T W TH F S
    ["M", "T", "W", "TH", "F", "SA"].each do |day|
      
      # look for list of daycode
      
      daycodes = case day
                  when "M"
                    DayCode.where("name IN(?)", ["MWF", "MW", "MF", "MTW", "MTWTHF"])
                  when "T"
                    DayCode.where("name IN(?)", ["TTH", "T", "THF", "MTWTHF", "TF"])
                  when "W"
                    DayCode.where("name IN(?)", ["MWF", "MW", "W", "MTW", "MTWTHF"])
                  when "TH"
                    DayCode.where("name IN(?)", ["TTH", "TH", "THF", "MTWTHF"])
                  when "F"
                    DayCode.where("name IN(?)", ["MWF", "F", "MF", "WF", "THF", "TF", "MTWTHF"])
                  when "SA"
                    DayCode.where("name IN(?)", ["SAT"])
                end
      
      TimeSchedule.find_each do |time_schedule|
        tt = time_schedule.time_range.split("-")
        time_start, time_end = tt[0], tt[1]
        
        if self.teacher_subjects.where({ time_start: (time_start)..(time_end) })
                                .where("day_code_id IN(?)", daycodes.pluck(:id)).empty?
                                        
          self.availabilities.create({ day: day, time_schedule_id: time_schedule.id  })
          
        end
      end
    end
    
  end

  def self.search(search_by, search)

    teacher_scope = self.scoped({})
    case search_by
        when 'Firstname'
           teacher_scope = teacher_scope.search_by_firstname(search)
        when 'Lastname'
            teacher_scope = teacher_scope.search_by_lastname(search)
        when 'Phone Number'
            teacher_scope = teacher_scope.search_by_phone(search)
        end
    return teacher_scope
  end

end
