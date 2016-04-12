class AddressesController < ApplicationController
  before_action :authenticate_user!

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
    reset_primary_address if address_params[:primary]
    @address = Address.new(address_params)

    if @address.save
      current_user.addresses << @address
      flash[:success] = "Your address information was saved successfully"
    else
      flash[:danger] = "Your address information was not saved. Please check all fields carefully and try again."
    end
      redirect_to user_path(current_user)
  end

  def update
    reset_primary_address if address_params[:primary]
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
