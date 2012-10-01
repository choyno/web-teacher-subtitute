class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	t.string :name , limit: 20
      t.timestamps
    end
  end
end
