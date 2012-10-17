class DropSubstituteColumn < ActiveRecord::Migration
	 def self.down
	  	remove_column :substitutes, :substitute_teacher_id 
	  	remove_column :substitutes, :reasons_id
	  	remove_column :substitutes, :teacher_subject_id
	  	remove_column :substitutes, :assigned_by_user_id
	  	remove_column :substitutes, :approved_by_user_id
	  end
end
