class AddProblemType < ActiveRecord::Migration
  def up
  	add_column :problems, :problem_type, :string
  end

  def down
  end
end
