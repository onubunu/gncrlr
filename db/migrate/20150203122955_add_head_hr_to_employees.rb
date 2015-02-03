class AddHeadHrToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :head_hr, :boolean, :default => false
    add_column :employees, :head_sales, :boolean, :default => false
    add_column :employees, :staff_hr, :boolean, :default => false
    add_column :employees, :staff_sales, :boolean, :default => false
  end
end
