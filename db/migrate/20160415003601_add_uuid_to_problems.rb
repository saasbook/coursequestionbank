class AddUuidToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :uuid, :string
  end
end
