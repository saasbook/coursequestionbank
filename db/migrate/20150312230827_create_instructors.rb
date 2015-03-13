class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :username
      t.string :privilege

      t.timestamps
    end
  end
end
