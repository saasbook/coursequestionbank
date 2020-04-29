class AddFkIndices < ActiveRecord::Migration
  def change
    add_index :collections, :instructor_id
    add_index :collections_problems, :problem_id
    add_index :collections_problems, :collection_id
    add_index :problems, :instructor_id
    add_index :problems, :previous_version_id
    add_index :problems_tags, :problem_id
    add_index :problems_tags, :tag_id
  end
end
