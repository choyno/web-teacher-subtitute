class AddColumnUserTypeInUsers < ActiveRecord::Migration
  
  def change
    add_column :users, :user_type, :string, limit: 50
    add_column :users, :status, :boolean, default: true
  end

end
