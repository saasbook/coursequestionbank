class CreateWhitelists < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.string :username
      t.string :privilege

      t.timestamps
    end
  end
end
