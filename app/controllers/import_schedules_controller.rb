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
    end
    redirect_to import_schedules_path, notice: 'Schedules sucessfully uploaded!'     
  end
end
