class AddColumnToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :json, :text
  end
end
