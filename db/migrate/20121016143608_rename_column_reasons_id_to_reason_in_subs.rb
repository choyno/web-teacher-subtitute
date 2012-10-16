class RenameColumnReasonsIdToReasonInSubs < ActiveRecord::Migration

  def change
    rename_column :substitutes, :reasons_id, :reason_id
  end

end
