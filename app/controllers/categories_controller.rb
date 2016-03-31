class CategoriesController < ApplicationController
  def show
    category_filters = params[:categories].split(",")
    @categories = Category.all.to_a
    @listings = Listing.joins(:categories).where("name IN (?)", category_filters).to_a
    render 'listings/index'
  end

  def index
    @categories = Category.all.to_a
    @listings = Listing.all.to_a
    render 'listings/index'
  end
end
