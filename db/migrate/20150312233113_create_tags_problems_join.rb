class CreateTagsProblemsJoin < ActiveRecord::Migration
  def up
    create_table 'problems_tags', :id => false do |t|
      t.column 'problem_id', :integer
      t.column 'tag_id', :integer
    end
  end
  def down
    drop_table 'problems_tags'
  end
end
