class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :text
      t.datetime :created_date
      t.string :created_by
      t.boolean :is_public
      t.datetime :last_used

      t.timestamps
    end
  end
end
