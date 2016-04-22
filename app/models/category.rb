class Category < ActiveRecord::Base
  has_many :listings_categories, dependent: :destroy
  has_many :listings, through: :listings_category
end
