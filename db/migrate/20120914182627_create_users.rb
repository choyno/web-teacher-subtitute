class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :fullname,limit :20
		t.string :username,limit :20
		t.string :password,limit :20
		t.integer :user_types_id
		department_id
		t.boolean :status

      t.timestamps
    end
  end
end
