class AddressesController < ApplicationController
  # TODO: Implement user-level authentication...maybe admin authentication too, if admins have access to this data
  before_action :get_address, only: [:edit, :update, :destroy]
  before_action :address_params, only: [:create, :update]

  private
    def address_params
      @address = Address.create(params.require(:address).permit(:street_address_1, :street_address_2,
                                                                :city, :state, :zip_code, :phone, :fax))
    end

    def get_address
      @address = Address.find(params[:id])
    end

  def index
    @addresses = Address.all()
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(params[:address])

    if @address.save
      redirect_to @address
    else
      render 'addresses/new'
    end
  end

  def update
    @address = Address.update(params[:address])

    if @address.save
      redirect_to @address
    else
      render 'addresses/edit'
    end
  end

  def destroy
    @address = Address.destroy(params[:address])

    @address.save

    redirect_to addresses_index_path
  end
end
