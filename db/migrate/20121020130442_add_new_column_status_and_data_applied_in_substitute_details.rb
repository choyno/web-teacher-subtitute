class AddNewColumnStatusAndDataAppliedInSubstituteDetails < ActiveRecord::Migration
  def up
  	add_column :substitute_details, :status, :boolean, default: false
  	add_column :substitute_details, :date_applied, :date 
  end
end


