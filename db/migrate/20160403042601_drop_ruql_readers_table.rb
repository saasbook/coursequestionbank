class DropRuqlReadersTable < ActiveRecord::Migration
  def up
    drop_table :ruql_readers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
