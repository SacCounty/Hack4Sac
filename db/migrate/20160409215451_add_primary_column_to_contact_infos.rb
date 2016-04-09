class AddPrimaryColumnToContactInfos < ActiveRecord::Migration
  def change
    add_column :contact_infos, :primary, :boolean, null: :false
  end
end
