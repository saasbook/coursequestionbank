class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :name
      t.datetime :last_used
      t.string :created_by
      t.boolean :is_public
      t.datetime :last_used

      t.timestamps
    end
  end
end
