class CreateSubstituteDetails < ActiveRecord::Migration
  def change
    create_table :substitute_details do |t|
    	t.integer :substitute_teacher_id 
	  	t.integer :reasons_id
	  	t.integer :teacher_subject_id
      t.timestamps
    end
  end
end
		