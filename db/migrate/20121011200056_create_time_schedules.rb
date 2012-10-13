class CreateTimeSchedules < ActiveRecord::Migration
  def change
    create_table :time_schedules do |t|
      t.string :time_range
    end
    
  end
end
