module ListingsHelper
  def is_followed?(listing_id)
    current_user && current_user.followed_listings.where(listing_id: listing_id).present?
  end

  def already_requested?
    current_user.donation_applications.where(listing: @listing).present?
  end

  def date_format(time)
    formatted_date = time.strftime("%d %b %Y") unless time.nil?
    formatted_date ||= ''
  end
end
