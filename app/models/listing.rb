class Listing < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :followed_listings
  has_many :followers, through: :followed_listings
  has_many :listings_categories, dependent: :destroy
  has_many :categories, through: :listings_categories
end
