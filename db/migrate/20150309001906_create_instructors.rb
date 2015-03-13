class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.string :privilege

      t.timestamps
    end
  end
end
