class CreateCollectionsInstructorsJoin < ActiveRecord::Migration
  def up
    create_table 'collections_instructors', :id=> false do |t|
      t.column 'collection_id', :integer
      t.column 'instructor_id', :integer
    end
  end

  def down
    drop_table 'collections_instructors'
  end
end
