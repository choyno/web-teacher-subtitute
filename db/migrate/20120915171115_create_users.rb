class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, limit: 120
      t.string :username, limit: 120
      t.string :password_hash
      t.string :password_salt
      t.integer :department_id

      t.timestamps
    end
  end
end
