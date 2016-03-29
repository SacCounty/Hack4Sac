class ListingsController < ApplicationController
  def new
	  @listing = Listing.new
  end

  def create
	  @listing = Listing.new(listing_params)
	  if @listing.save
		  redirect_to listings_path, :notice => "Your listing has been saved"
	  else
      render :action => 'new'
    end
  end

  def index
    @categories = Category.all.to_a
    @listings = Listing.all
  end

  def show
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

  def destroy
  end

  private

  def listing_params
   params.require(:listings).permit(:title, :description, :fair_market_value)
  end
end


