class TeacherSchedule < ActiveRecord::Base
  # attr_accessible :title, :body
  
  
  belongs_to :teacher_subject
  belongs_to :time_schedule
  
end
