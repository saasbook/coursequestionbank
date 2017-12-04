class AddAccessCollection < ActiveRecord::Migration
  def up
    add_column :collections, :access_level, :int, :default => 1
    Collection.all().each do |collection|
      if collection.is_public
        collection.access_level = 1
        collection.save!
      else
        collection.access_level = 3
        collection.save!
      end
    end
  end

  def down
    remove_column :collections, :access_level, :int
  end
end