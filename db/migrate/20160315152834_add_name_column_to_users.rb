class AddNameColumnToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :entity_name
      t.string :entity_license
    end
  end
end
