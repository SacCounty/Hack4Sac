class AddPrimaryColumnToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :primary, :boolean
  end
end
