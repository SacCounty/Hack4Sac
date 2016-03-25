class ListingsController < ApplicationController
  def new
	  @listing = Listing.new
	  @user = User.all
  end

  def create
	  @listing = Listing.new(listing_params)
	  if @listing.save
		  redirect_to listings_path, :notice => "Your listing has been saved"
	  else
	      render :action => 'new'
  end
  
  end

  def listing_params
   params.require(:listings).permit(:title, :description, :fair_market_value, :user_id, :created_at, :updated_at)
  end
  
  def index
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
	if @listing.update_attributes(listing_param)
	    redirect_to listing_path, :notice => "Your listing has been updated"
	else
		render :action => 'edit'
  end
  
  end

  def listing_param
   params.require(:listing).permit(:title, :description, :fair_market_value, :user_id, :created_at, :updated_at)
  end

  def destroy
  end
end


