class AddImgLinkColumnToListings < ActiveRecord::Migration
  def change
   change_table :listings do |t|
      t.string :image_url
    end
  end
end
