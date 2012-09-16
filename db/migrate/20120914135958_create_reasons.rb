class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
    	t.string :name, limit :20

      t.timestamps
    end
  end
end
