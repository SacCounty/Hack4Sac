class ListingsController < ApplicationController
  def new
	  @listing = Listing.new
	  @user = User.all
  end

  def create
	  @listing = Listing.new(params[:listing])
	  if @listing.save
		  redirect_to listings_path, :notice => "Your listing has been saved"
	  else
	      render "new"
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
	if @listing.update_attributes(params [:listing])
	    redirect_to listing_path, :notice => "Your listing has been updated"
	else
		render "edit"
  end


  def destroy
  end
end

