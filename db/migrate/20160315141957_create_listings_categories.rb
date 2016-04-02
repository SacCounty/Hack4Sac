class CreateListingsCategories < ActiveRecord::Migration
  def change
    create_table :listings_categories do |t|
      t.belongs_to :category, index: true
      t.belongs_to :listing, index: true
      t.timestamps null: false
    end
  end
end
