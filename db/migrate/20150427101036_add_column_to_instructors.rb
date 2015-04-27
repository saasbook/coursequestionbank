class AddColumnToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :provider_image, :string
  end
end
