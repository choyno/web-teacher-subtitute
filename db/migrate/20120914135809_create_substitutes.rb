class CreateSubstitutes < ActiveRecord::Migration
  def change
    create_table :substitutes do |t|
      
    	t.integer   :substitute_teacher_id
  		t.integer   :reasons_id
  		t.text      :notes
  		t.integer   :teachers_subject_id
  		t.boolen    :planned
  		t.integer   :status_id
  		t.datetime  :requested_at
  		t.integer   :assigned_by_user_id
  		t.datetime  :approved_at
  		t.integer   :approved_by_user_id

      t.timestamps
    end
  end
end
