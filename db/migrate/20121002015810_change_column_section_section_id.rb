class ChangeColumnSectionSectionId < ActiveRecord::Migration
  def up
  	rename_column :teacher_subjects, :section, :section_id
  	change_column :teacher_subjects, :section_id, :integer

  end

  def down
  		change_column :teacher_subjects, :section_id, :string
  		rename_column :teacher_subjects, :section_id, :section
  end
end
