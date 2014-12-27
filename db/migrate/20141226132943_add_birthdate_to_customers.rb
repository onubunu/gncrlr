class AddBirthdateToCustomers < ActiveRecord::Migration
  def up
    add_column :customers, :birthdate, :datetime
  end
end
