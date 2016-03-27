class AddPhoneFaxToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :phone, :string
    add_column :addresses, :fax, :string
  end
end
