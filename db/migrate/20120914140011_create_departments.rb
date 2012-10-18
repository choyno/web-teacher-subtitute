class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
    	t.string :name, limit: 120
    end
  end
end
