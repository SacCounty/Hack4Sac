class AddReferenceToAddresses < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.string :address_type
      t.belongs_to :user, index: true
    end
  end
end
