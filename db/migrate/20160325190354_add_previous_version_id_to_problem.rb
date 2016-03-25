class AddPreviousVersionIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :previous_version_id, :integer
  end
end
