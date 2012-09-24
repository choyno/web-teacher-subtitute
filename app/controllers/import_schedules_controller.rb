class ImportSchedulesController < ApplicationController
  
  def index
    
    @schedule_file = ScheduleFile.new()
    
  end
  
  def create
    
    schedule_file = ScheduleFile.new(params[:schedule_file])
    
    schedule_file.save
    
    book = Spreadsheet.open(schedule_file.excel_file.current_path)
            
    sheet1 = book.worksheet 0
        
    sheet1.each 1 do |row|
      
      # import subject
      subject = Subject.find_or_create_by_name_and_code(row[1], row[0])
      
      # need to parse teacher name to separate lastname and firstname
      teacher_name = row[5].to_s.split(',')
      last_name = teacher_name[0].to_s.strip
      temp = teacher_name[1].to_s
      first_name = temp[0, temp.length - 2].to_s.strip
      
      teacher = Teacher.find_or_create_by_firstname_and_lastname(first_name, last_name)

      
      # day code
      day_code = DayCode.find_or_create_by_name(row[2])
      
      # room_number
      room_number = row[3].to_s
      
      # section
      section = row[4].to_s
      
      # type
      
      schedule_type = row[7].to_s
      
      # need to breack time to get start and end
      time = row[6].to_s.split('-')
      time_start = Time.parse(time[0]).localtime
      time_end = Time.parse(time[1]).localtime
      
      teacher_subject = TeacherSubject.new({ teacher_id: teacher.id, subject_id: subject.id, 
                                             time_start: time_start, time_end: time_end,
                                             room_num: room_number, day_code_id: day_code.id,
                                             section: section, subject_type: schedule_type
                                          })
                                        
      teacher_subject.save
      
      
    end
      
    redirect_to import_schedules_path, notice: 'Schedules was sucessfully uploaded!'  

  end
end
