class AddPriviledge < ActiveRecord::Migration
  def up
    add_column :instructors, :privilege, :string
  end

  def down
    remove_column :instructors, :privilege, :string
  end
end
