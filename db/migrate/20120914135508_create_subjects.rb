class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
     	t.string :code, limit: 20
     	t.string :name
      t.timestamps
    end
  end
end
