class ChangedStudentAnswerName < ActiveRecord::Migration
  def up
    drop_table :student_answer

    create_table :studentanswers do |a|
      a.string :attempt
      a.boolean :correctness
      a.string :problem_uid
      a.timestamps
      a.references :instructor
      a.references :problem
    end
  end

  def down
    drop_table :studentanswers
  end
end
