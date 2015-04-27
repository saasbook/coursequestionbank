class AddEmailColumnToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :provider_email, :string
  end
end
