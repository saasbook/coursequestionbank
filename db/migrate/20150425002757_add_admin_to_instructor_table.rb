class AddAdminToInstructorTable < ActiveRecord::Migration
  def change
    add_column :instructors, :type, :string
  end
end
