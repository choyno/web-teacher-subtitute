class ChangeColumnRoomNumInTeacherSubject < ActiveRecord::Migration
 
  def change
  	change_column :teacher_subjects, :room_num, :string 
  end

end
