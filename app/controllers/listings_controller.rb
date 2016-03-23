class ListingsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
  end

  def update
  end


  def destroy
  end
end
