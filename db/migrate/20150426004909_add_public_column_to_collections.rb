class AddPublicColumnToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :is_public, :boolean
  end
end
