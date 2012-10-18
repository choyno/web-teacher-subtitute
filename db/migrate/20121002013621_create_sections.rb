class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
    	t.string :name , limit: 20
      t.timestamps
    end
  end
end
