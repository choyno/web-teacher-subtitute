class CreateDayCodes < ActiveRecord::Migration
  def change
    create_table :day_codes do |t|
    	t.string :name, limit: 20
    end
  end
end
