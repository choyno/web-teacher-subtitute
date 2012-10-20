class ChangeColumnStatusIdToStatus < ActiveRecord::Migration
  def up
  	rename_column :substitutes, :status_id, :status
  	change_column :substitutes, :status, :string
  end

  def down
  	#change me
  	change_column :substitutes, :status, :integer
  	rename_column :substitutes, :status, :status_id
  end  
end
