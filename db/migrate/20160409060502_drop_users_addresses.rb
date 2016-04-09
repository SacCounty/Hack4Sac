class DropUsersAddresses < ActiveRecord::Migration
  def change
    drop_table :users_addresses
  end
end
