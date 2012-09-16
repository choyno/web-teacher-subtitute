class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
    	t.string :name, limit :20

      t.timestamps
    end
  end
end
