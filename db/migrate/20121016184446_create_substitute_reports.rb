class CreateSubstituteReports < ActiveRecord::Migration
  def change
    create_table :substitute_reports do |t|
      t.integer :substitute_id
      t.integer :teacher_id
      t.integer :teacher_substitute_id
      t.integer :teacher_subject_id
      t.float   :total_hours
      t.date    :date_applied
    end
  end
end
