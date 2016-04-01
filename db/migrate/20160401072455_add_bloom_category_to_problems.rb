class AddBloomCategoryToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :bloom_category, :string
  end
end
