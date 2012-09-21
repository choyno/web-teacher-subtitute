class ScheduleFile < ActiveRecord::Base
  # attr_accessible :title, :body
  
  mount_uploader :excel_file, TeachersSchedulesUploader
  
end
