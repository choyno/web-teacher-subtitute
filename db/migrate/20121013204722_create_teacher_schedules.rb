class CreateTeacherSchedules < ActiveRecord::Migration
  def change
    create_table :teacher_schedules do |t|
      t.string :day, limit: 5
      t.integer :teacher_subject_id
      t.integer :time_schedule_id
    end
  end
end
