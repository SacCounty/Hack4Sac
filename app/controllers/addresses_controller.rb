class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_primary_address, only: [:create, :update]

  def index
    redirect_to user_path(current_user)
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def edit_all
    @addresses = current_user.addresses
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      current_user.addresses << @address
      redirect_to user_address_path(id: @address.id, user_id: current_user.id)
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    current_user.addresses.find(params[:id]).delete

    redirect_to user_path(current_user)
  end

  protected
    def reset_primary_address
      current_user.addresses.each do |address|
        address.update_attributes(primary: false)
      end
    end

  private
    def address_params
      params.require(:address).permit(:street_address_1,
                                      :street_address_2,
                                      :city,
                                      :state,
                                      :zip_code,
                                      :address_type,
                                      :primary)
    end
end
