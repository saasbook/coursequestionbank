class RemoveSucceedingVersionIdFromProblems < ActiveRecord::Migration
  def up
    remove_column :problems, :succeeding_version_id
  end

  def down
    add_column :problems, :succeeding_version_id, :integer
  end
end
