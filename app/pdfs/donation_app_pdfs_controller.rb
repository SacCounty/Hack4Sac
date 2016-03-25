class DonationAppPdfsController < ApplicationController
  # TODO: implement user authentication

  def show
    user = User.find(params[:user_id])
    user_q = user.users_questionnaires
    listing = Listing.find(params[:listing_id])

    respond_to do |format|
      format.pdf(send_file DonationApplicationPdf.new(user_q, listing).export, type: 'application/pdf')
    end
  end
end