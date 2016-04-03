class DonationApplicationsController < ApplicationController
  before_action :donation_application_params, only: :create
  before_action :get_listing, only: :create
  before_action :get_user, only: :create

  def create
    @donation_application = DonationApplication.new(@user, @user.questionnaire, @listing)
    @pdf = DonationApplication.get_pdf_form(@listing, @user)

    if @pdf
      submit_status = "Printed"
    else
      submit_status = "Emailed"
    end

    @donation_application.submit_status = submit_status

    if @donation_application.save
      @listing.follow
      flash[:success] = 'Your request has been ' + submit_status + '!'
    else
      flash[:danger] = 'Your request was not saved, please try again'
    end

    redirect_to @listing
  end

  private
    def donation_application_params
      @donation_application_params = params.require(:listing).permit(:id)
    end

    def get_listing
      @listing = Listing.find(params[:id])
    end

    def get_user
      @user = current_user
    end
end
