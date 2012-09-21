class CreateScheduleFiles < ActiveRecord::Migration
  def change
    create_table :schedule_files do |t|
      t.string :excel_file, limit: 150
      t.timestamps
    end
  end
end
