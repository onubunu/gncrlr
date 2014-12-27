class AddTitleToCustomers < ActiveRecord::Migration
  def up
    add_column :customers, :title, :string
  end
end
