class DonationApplicationMailer < ApplicationMailer
  before_action :don_app_mailer_params
  before_action :get_listing
  before_action :get_donee
  before_action :get_donor

  def donation_request
    @subject = 'Request Submitted for Listing "' + @listing.title + '" (ID #' + @listing.id + ')'
    mail(to: @user.email, subject: @subject)
  end

  def donation_pdf_mailed
    @subject = 'Sac County Donation Request Form Mailed'
    mail(to: @donor.email, subject: @subject)
  end

  private
    def don_app_mailer_params
      @don_app_mailer_params = params.require(:listing).permit(:id)
    end
  
    def get_donee
      @donee = current_user
    end
  
    def get_donor
      @donor = User.find(@listing.user_id)
    end
  
    def get_listing
      @listing = Listing.find(params[:id])
    end
end
