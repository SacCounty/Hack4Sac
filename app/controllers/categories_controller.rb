class CategoriesController < ApplicationController
  def show
    categories = params[:categories].split(",")
    @listings = Listing.joins(:categories).where("name IN (?)", categories).to_a
    render 'listings/index'
  end

  def index
    @categories = Category.all.to_a
    @listings = Listing.all.to_a
    render 'listings/index'
  end
end
