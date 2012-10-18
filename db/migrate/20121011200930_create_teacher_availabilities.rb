class CreateTeacherAvailabilities < ActiveRecord::Migration
  def change
    create_table :teacher_availabilities do |t|
      t.integer :teacher_id
      t.string :day, limit: 2
      t.integer :time_schedule_id
    end
  end
end
