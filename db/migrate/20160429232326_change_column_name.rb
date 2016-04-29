class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :problems, :uuid, :uid
  end
end