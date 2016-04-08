class DonationApplicationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @listing = Listing.find(params[:id])
    submission_status ||= "printed" if requires_pdf_form?
    submission_status ||= "emailed"
    donation_application = DonationApplication.new(applicant: current_user, listing: @listing, submission_status: submission_status)

    if donation_application.save
      @listing.followers << current_user
      # Mailer send
      if requires_pdf_form?
        export_pdf and return
      end
      flash[:success] = "Your request has been #{submission_status}!"
    else
      flash[:danger] = "Your request was not saved, please try again"
    end

    redirect_to listing_path(@listing)
  end

  private

  def export_pdf
    pdf_form = DonationApplicationPdf.new(user: current_user, listing: @listing).export
    send_file(pdf_form, type: 'application/pdf')
  end

  def requires_pdf_form?
    # !Listing.find(listing_id).pdf.nil?
    @listing.creator.entity_name == "Sacramento County"
  end

  private

  def donation_application_params
    params.require(:donation_application).permit(:submission_status, :submission_date, :approval_status, :approval_status_reason)
  end
end
