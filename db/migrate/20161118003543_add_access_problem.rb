class AddAccessProblem < ActiveRecord::Migration
  def up
    add_column :problems, :access_level, :int, :default => 1
    Problem.all().each do |problem|
      if problem.is_public
        problem.access_level = 1
        problem.save!
      else
        problem.access_level = 3
        problem.save!
      end
    end
  end

  def down
    remove_column :problems, :access_level, :int
  end
end
