class RemovePhoneAndFaxColumnFromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :phone
    remove_column :addresses, :fax
  end
end
