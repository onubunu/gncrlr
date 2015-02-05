class AddHeadBuyingToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :head_buying, :boolean, :default => false
    add_column :employees, :staff_buying, :boolean, :default => false
  end
end
