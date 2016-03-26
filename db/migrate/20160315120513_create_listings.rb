class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :fair_market_value, precision: 10, scale: 2, null: false, default: 0.0
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
