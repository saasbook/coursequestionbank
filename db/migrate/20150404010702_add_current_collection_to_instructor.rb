class AddCurrentCollectionToInstructor < ActiveRecord::Migration
  def change
  	add_column :instructors, :current_collection, :integer
  end
end
