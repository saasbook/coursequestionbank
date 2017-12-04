class AddStudentAnswer < ActiveRecord::Migration
  def up
    create_table :student_answer do |a|
      a.string :attempt
      a.boolean :correctness
      a.string :problem_uid
      a.timestamps
      a.references :instructor
      a.references :problem
    end
  end

  def down
    drop_table :student_answer
  end
end
