class CategoriesController < ApplicationController
  def index
    @categories = Category.all.to_a
    unless params[:categories] and
      params[:categories].values.length != @categories.length
        redirect_to listings_path and return
    end
    @category_filters = params[:categories].values
    @listings = Listing.joins(:categories).where("name IN (?)", params[:categories].values)
    session.delete(:listings_index)
    render 'listings/index'
  end
end
