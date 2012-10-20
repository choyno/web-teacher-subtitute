class AddColumnTeacherIdInSubDetails < ActiveRecord::Migration

  def change
    add_column :substitute_details, :teacher_id, :integer
  end

end