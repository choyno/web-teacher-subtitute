class AddColumnTeacherIdInSubstitute < ActiveRecord::Migration

  def change
    add_column :substitutes, :teacher_id, :integer
  end
  

end