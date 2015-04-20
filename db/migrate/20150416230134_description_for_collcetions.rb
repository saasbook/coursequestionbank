class DescriptionForCollcetions < ActiveRecord::Migration
  def up
    add_column :collections, :description, :text
  end

  def down
  end
end
