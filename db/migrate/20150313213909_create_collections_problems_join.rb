class CreateCollectionsProblemsJoin < ActiveRecord::Migration
  def up
    create_table 'collections_problems', :id=> false do |t|
      t.column 'collection_id', :integer
      t.column 'problem_id', :integer
    end
  end

  def down
    drop_table 'collections_problems'
  end
end
