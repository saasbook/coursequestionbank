class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.datetime :last_used

      t.timestamps
    end
  end
end
