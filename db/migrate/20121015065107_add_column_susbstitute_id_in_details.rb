class AddColumnSusbstituteIdInDetails < ActiveRecord::Migration
  
  def change
    add_column :substitute_details, :substitute_id, :integer
  end

end