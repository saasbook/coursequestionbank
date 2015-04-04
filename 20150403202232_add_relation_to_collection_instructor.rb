class AddRelationToCollectionInstructor < ActiveRecord::Migration
  def change
  	add_column :collections, :instructor_id, :integer
  end
end
