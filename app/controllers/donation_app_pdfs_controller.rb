class DonationAppPdfsController < ApplicationController
  def show
    #user = User.find(params[:user_id])
    #user_q = user.users_questionnaires
    #listing = Listing.find(params[:listing_id])

    user = User.new
    user_q = UsersQuestionnaire.new
    listing = Listing.new
    address = Address.new

    respond_to do |format|
      format.pdf { send_file DonationApplicationPdf.new(user, address, listing, user_q).export, type: 'application/pdf' }
    end
  end
end
