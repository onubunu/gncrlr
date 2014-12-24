class AddPhoneToCustomers < ActiveRecord::Migration
  def up
    add_column :customers, :phone, :string
    add_index :customers, :phone, unique: true
  end
end