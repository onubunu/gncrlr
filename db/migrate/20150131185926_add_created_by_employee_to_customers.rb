class AddCreatedByEmployeeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :created_by_employee, :boolean, :default => false
  end
end
