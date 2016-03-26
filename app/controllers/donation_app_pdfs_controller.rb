class DonationAppPdfsController < ApplicationController
  def show
    user = current_user
    listing = Listing.find(params[:listing_id])

    respond_to do |format|
      format.pdf { send_file DonationApplicationPdf.new(user, listing).export, type: 'application/pdf' }
    end
  end
end
