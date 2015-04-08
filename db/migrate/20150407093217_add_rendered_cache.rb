class AddRenderedCache < ActiveRecord::Migration
  def up
  	add_column :problems, :rendered_text, :text
  end

  def down
  end
end
