class AddColorToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :color, :string
  end
end
