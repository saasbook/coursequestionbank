class AddObsoleteToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :obsolete, :boolean
  end
end
