class ChangeColumnTypeIntoClasstypeId < ActiveRecord::Migration
  def up
  	rename_column :teacher_subjects, :subject_type, :subject_type_id
  	change_column :teacher_subjects, :subject_type_id, :integer
  end

  def down
  	
  	change_column :teacher_subjects, :subject_type_id, :string
  	rename_column :teacher_subjects, :subject_type_id, :type
  end
end
