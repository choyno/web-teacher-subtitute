class AddColumnTeacherSubjectsTimeStart < ActiveRecord::Migration

  def change
    add_column :teacher_subjects, :time_start, :time
    rename_column :teacher_subjects, :type, :subject_type
  end

end