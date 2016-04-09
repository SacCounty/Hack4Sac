class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :title
      t.string :phone, null: false
      t.string :extension
      t.string :fax
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
