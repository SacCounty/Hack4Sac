class CreateUsersAddresses < ActiveRecord::Migration
  def change
    create_table :users_addresses do |t|
      t.string :type, null: false, default: "Mailing"
      t.belongs_to :user, index: true
      t.belongs_to :address, index: true
      t.timestamps null: false
    end
  end
end
