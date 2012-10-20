class ChangeStatusIntoDeleted < ActiveRecord::Migration
  def up
  	rename_column :substitute_details, :status, :deleted
  end

  def down
  	rename_column :substitute_details, :deleted, :status
  end
end
