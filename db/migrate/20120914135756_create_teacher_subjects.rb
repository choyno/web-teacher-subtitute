class CreateTeacherSubjects < ActiveRecord::Migration
  def change
    create_table :teacher_subjects do |t|
      
    	t.integer :teacher_id
  		t.integer :subject_id
  		t.time    :time_end
  		t.integer :room_num
  		t.integer :day_code_id
  		t.string  :section, limit: 20
  		t.string  :type, limit: 120

      t.timestamps
    end
  end
end
