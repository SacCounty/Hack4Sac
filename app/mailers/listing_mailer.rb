class ListingMailer < ApplicationMailer
  before_action :listing_mailer_params
  before_action :get_listing
  before_action :get_donee
  before_action :get_donor

  # donor and donee are the corresponding Users
  def confirm_follow_listing
    @subject = 'Your Interest in Listing #' + @listing.id + ' has been sent!'
    mail(to: @donee.email, subject: @subject)
  end

  # donor and donee are the corresponding Users
  def follow_listing
    @subject = 'HareTech (' + @donee.address.city + '): Interest in Listing #' + @listing.id
    mail(to: @donor.email, subject: @subject)
  end

  private
    def listing_mailer_params
      @listing_mailer_params = params.require(:listing).permit(:id)
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
