class DonationApplicationsController < ApplicationController
  include DonationApplicationsHelper
  before_action :authenticate_user!

  def create
    @listing = Listing.find(params[:listing_id])
    submission_status ||= "printed" if @listing.requires_pdf_form?
    submission_status ||= "emailed"
    donation_application = DonationApplication.new(applicant: current_user, listing: @listing, submission_status: submission_status)

    if donation_application.save
      @listing.followers << current_user
      # Mailer send
      if @listing.requires_pdf_form?
        export_pdf and return
      end
      flash[:success] = "Your request has been #{submission_status}!"
    else
      flash[:danger] = "Your request was not saved, please try again"
    end

    redirect_to listing_path(@listing)
  end

  end

  private

  def donation_application_params
    params.require(:donation_application).permit(:submission_status, :submission_date, :approval_status, :approval_status_reason)
  end
end
