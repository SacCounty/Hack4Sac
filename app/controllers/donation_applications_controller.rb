class DonationApplicationsController < ApplicationController
  include DonationApplicationsHelper
  before_action :authenticate_user!

  def create
    @listing = Listing.find(params[:listing_id])
    submission_status ||= "printed" if @listing.requires_pdf_form?
    submission_status ||= "emailed"
    donation_application = DonationApplication.new(applicant: current_user, listing: @listing, submission_status: submission_status)

    if donation_application.save
      unless @listing.followers.include?(current_user)
        @listing.followers << current_user
      end
      # Mailer send
      if @listing.requires_pdf_form?
        export_pdf and return
      else
        donation_application.update(submission_date: Time.now)
      end
      flash[:success] = "Your application has been #{submission_status}!"
    else
      flash[:danger] = "Your request was unsuccessful, please try again"
    end

    redirect_to listing_path(@listing)
  end

  def show
    @listing = Listing.find(params[:listing_id])
    display_pdf
  end

  def update_mailed_submission
    listing = Listing.find(params[:listing_id])
    donation_application = current_user.donation_applications.find_by(listing: listing)

    if donation_application.update_attributes(submission_status: "mailed", submission_date: Time.now)
      flash[:success] = "Your submission status has been updated"
    else
      flash[:danger] = "Your request was unsuccessful, please try again"
    end

    redirect_to listing_path(listing)
  end

  private

  def donation_application_params
    params.require(:donation_application).permit(:submission_status, :submission_date, :approval_status, :approval_status_reason)
  end
end
