class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @listing = Listing.new
    @listing.categories.build
  end

  def create
    @listing = Listing.new(listing_params.merge! creator: current_user)

    if @listing.save
      @listing.categories << Category.find(params[:listing][:category_ids])
      redirect_to listings_path, :notice => "Your listing has been saved"
    else
      redirect_to new_listing_path, :notice => "Your listing could not be created. Make sure all fields are filled out and try again."
    end
  end

  def index
    session.delete(:listings_index)
    @categories = Category.all.to_a
    @listings = Listing.all
  end

  def show
    set_listings_index
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(listing_params)
        redirect_to listing_path, :notice => "Your listing has been updated"
    else
      redirect_to edit_listing_path, :notice => "Your listing could not be updated. Make sure all fields are filled out and try again."
    end
  end

  def donation_history
    @listings = Listing.where(creator: current_user).to_a
    render 'listings/index'
  end

  def request_history
    followed_listings = current_user.followed_listings.to_a
    @listings = followed_listings.map { |l| l = l.listing }
    render 'listings/index'
  end

  def destroy
    Listing.destroy(params[:id])
    redirect_to user_donations_path, :notice => "Your listing has been removed."
  end

  def follow
    listing_id = params[:id]
    unless view_context.is_followed? listing_id
      watchlist = current_user.followed_listings.build(listing_id: listing_id).save
      redirect_to :back
    end
  end

  def unfollow
    listing_id = params[:id]
    if view_context.is_followed? listing_id
      follow_id = current_user.followed_listings.where(listing_id: listing_id).first.id
      current_user.followed_listings.delete(follow_id)
      redirect_to :back
    end
  end

  private

  def set_listings_index(default = listings_path )
    prev_page = request.env["HTTP_REFERER"]
    if prev_page.present? && prev_page.include?("browse")
      session[:listings_index] ||= prev_page
    else
      session[:listings_index] ||= default
    end
  end

  def listing_params
   params.require(:listing).permit(:id, :title, :description, :fair_market_value)
  end
end
