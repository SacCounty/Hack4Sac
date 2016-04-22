class DonationAppPdfsController < ApplicationController
  before_action :authenticate_user!

  def show
    user_q = current_user.questionnaires.where(name: current_user.account_type).first
    listing = Listing.find(params[:listing_id])

    respond_to do |format|
      format.pdf(send_file DonationApplicationPdf.new(user_questionnaire: user_q, listing: listing).export, type: 'application/pdf')
    end
  end
end
