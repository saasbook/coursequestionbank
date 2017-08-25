class MakeAllPrivate < ActiveRecord::Migration
  def up
      Problem.all().each do |problem|
          problem.access_level = 2
          problem.save!
      end

      Collection.all().each do |problem|
          problem.access_level = 2
          problem.save!
      end
  end

  def down
  end
end
