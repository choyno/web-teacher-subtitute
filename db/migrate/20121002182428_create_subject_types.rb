class CreateSubjectTypes < ActiveRecord::Migration
  def change
    create_table :subject_types do |t|
      t.string :name, limit: 20
      t.timestamps
    end
  end
end
