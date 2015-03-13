class CreateInstructorsProblemsJoin < ActiveRecord::Migration
  def up
    create_table 'instructors_problems', :id=> false do |t|
      t.column 'instructor_id', :integer
      t.column 'problem_id', :integer
    end
  end

  def down
    drop_table 'instructors_problems'
  end
end
