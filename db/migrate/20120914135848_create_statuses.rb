class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
    	t.string :name, limit :20

      t.timestamps
    end
  end
end
