class Listing < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :followed_listings
  has_many :followers, through: :followed_listings
  has_many :listings_categories, dependent: :destroy
  has_many :categories, through: :listings_categories
  has_many :donation_application_trackers

  def get_show_image
    show_image = Listing.find(:params[:id]).image_url
    default_image = 'http://placehold.it/400x300&text=[img]'

    if show_image == nil
      show_image = default_image
    end
  end
end
