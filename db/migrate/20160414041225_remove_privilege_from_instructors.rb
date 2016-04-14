class RemovePrivilegeFromInstructors < ActiveRecord::Migration
  def up
    remove_column :instructors, :privilege
    remove_column :instructors, :type
  end

  def down
    add_column :instructors, :privilege, :string
    add_column :instructors, :type, :string
  end
end
