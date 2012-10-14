class AddColumnRequestAtInSubstitute < ActiveRecord::Migration
  
  def change
    add_column :substitutes, :request_at_from, :date
    add_column :substitutes, :request_at_to, :date
  end


end