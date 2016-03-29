class RenameUserIndex < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :type, :account_type
    end
  end
end
