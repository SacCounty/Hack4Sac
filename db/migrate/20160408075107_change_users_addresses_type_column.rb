class ChangeUsersAddressesTypeColumn < ActiveRecord::Migration
  def change
    remove_column :users_addresses, :type
    add_column :users_addresses, :address_type, :string
  end
end
