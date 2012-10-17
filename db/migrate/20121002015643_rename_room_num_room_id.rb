class RenameRoomNumRoomId < ActiveRecord::Migration
  def change
  	rename_column :teacher_subjects, :room_num ,:room_id

  end
end
