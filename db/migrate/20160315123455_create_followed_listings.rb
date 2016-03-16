class CreateFollowedListings < ActiveRecord::Migration
  def change
    create_table :followed_listings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :listing, index: true
      t.timestamps null: false
    end
  end
end
