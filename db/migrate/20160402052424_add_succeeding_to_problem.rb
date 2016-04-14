class AddSucceedingToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :succeeding_version_id, :integer
  end
end
