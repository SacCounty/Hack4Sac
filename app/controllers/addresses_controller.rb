class AddressesController < ApplicationController
  # TODO: Implement user-level authentication...maybe admin authentication too, if admins have access to this data
  before_action :get_address, only: [:edit, :update, :destroy]
  before_action :address_params, only: [:create, :update]

  def index
    @addresses = Address.all
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(@address_params)
  end

  def edit_all
    @addresses = current_user.addresses
  end

  def create
    @address = Address.new(@address_params)

    if @address.save
      redirect_to @address
    else
      return_to_index
    end
  end

  def update
    @address = Address.update(@address_params)

    if @address.save
      redirect_to @address
    else
      return_to_index
    end
  end

  def destroy
    @address = Address.destroy(params[:address])

    @address.save

    return_to_index
  end

  private
    def address_params
      @address_params = params.require(:address).permit(:street_address_1, :street_address_2,
                                                                :city, :state, :zip_code, :phone, :fax)
    end

    def get_address
      @address = Address.find(params[:id])
    end

    def return_to_index
      render 'addresses/index'
    end
end
