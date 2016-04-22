class AddIndexToUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :type
      t.index :type
    end
  end
end
