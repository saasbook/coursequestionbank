class Studentanswer < ActiveRecord::Base
  attr_accessible :attempt, :correctness, :problem_uid, :last_used, :updated_at, :created_date, :instructor_id,:first
  belongs_to :instructor
  belongs_to :question
end
