class RenameColumnTeacherSubjectInSubstitute < ActiveRecord::Migration
  
  def change
    rename_column :substitutes, :teachers_subject_id, :teacher_subject_id
  end

end
