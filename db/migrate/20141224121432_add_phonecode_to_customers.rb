class AddPhonecodeToCustomers < ActiveRecord::Migration
  def up
    add_column :customers, :phonecode, :string
  end
end
