class AddNewCOlForStudentasnwertable < ActiveRecord::Migration
  def change
    add_column :studentanswers, :first, :boolean
  end
end
