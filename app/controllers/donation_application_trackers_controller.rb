class DonationApplicationTrackersController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.build_donation_application(listing: @listing)
  end

  def show
  end

  def update
  end

  private

  def da_tracker_params
   params.require(:donation_application_tracker).permit(:listing_id)
  end
end
