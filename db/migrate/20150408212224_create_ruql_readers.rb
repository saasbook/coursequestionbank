class CreateRuqlReaders < ActiveRecord::Migration
  def change
    create_table :ruql_readers do |t|

      t.timestamps
    end
  end
end
