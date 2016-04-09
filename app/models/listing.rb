class Listing < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :followed_listings, dependent: :destroy
  has_many :followers, through: :followed_listings
  has_many :listings_categories, dependent: :destroy
  has_many :categories, through: :listings_categories
  has_many :donation_applications, dependent: :destroy

  def get_show_image
    listing_image = Listing.find(params[:id]).image_url || 'http://placehold.it/400x300&text=[img]'
    listing_image
  end
end
