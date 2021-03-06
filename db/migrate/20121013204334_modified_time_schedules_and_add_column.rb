class ModifiedTimeSchedulesAndAddColumn < ActiveRecord::Migration

  def change
    add_column :time_schedules, :time_start, :time
    add_column :time_schedules, :time_end, :time
    
    
     list_of_times = [ "7:00 - 7:30",
                        "7:30 - 8:00",
                        "8:00 - 8:30",
                        "8:30 - 9:00",
                        "9:00 - 9:30",
                        "9:30 - 10:00",
                        "10:00 - 10:30",
                        "10:30 - 11:00",
                        "11:00 - 11:30",
                        "11:30 - 12:00",
                        "13:00 - 13:30",
                        "13:30 - 14:00",
                        "14:00 - 14:30",
                        "14:30 - 15:00",
                        "15:30 - 16:00",
                        "16:00 - 16:30",
                        "16:30 - 17:00",
                        "17:00 - 17:30",
                        "17:30 - 18:00",
                        "18:00 - 18:30",
                        "18:30 - 19:00",
                        "19:00 - 19:30",
                        "19:30 - 20:00",
                        "20:00 - 20:30",
                        "20:30 - 21:00",
                        "21:00 - 21:30",
                        "21:30 - 22:00",
                        "22:00 - 22:30",
                        "22:30 - 23:00"
                      ].each do |tt|
                        
                        tt = tt.split("-")
                        
                        TimeSchedule.create({ time_start: tt[0].strip, time_end: tt[1].strip })
                        
                      end
    
    
  end

end