module ListingsHelper
  def is_followed?(listing_id)
    current_user && current_user.followed_listings.where(listing_id: listing_id).present?
  end
end
