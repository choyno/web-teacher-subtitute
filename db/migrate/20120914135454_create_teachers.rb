class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :firstname ,limit: 20 
      t.string :lastname  ,limit: 20
      t.string :phone_number ,limit: 20

      t.timestamps
    end
  end
end
