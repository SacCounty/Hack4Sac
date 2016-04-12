class ContactInfosController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to user_path(current_user)
  end

  def show
    @contact_info = ContactInfo.find(params[:id])
  end

  def new
    @contact_info = ContactInfo.new
  end

  def edit
    @contact_info = ContactInfo.find(params[:id])
  end

  def edit_all
    @contact_infos = current_user.contact_infos
  end

  def create
    reset_primary_contact if contact_info_params[:primary]
    @contact_info = ContactInfo.new(contact_info_params)

    if @contact_info.save
      current_user.contact_infos << @contact_info
      flash[:success] = "Your contact information was saved successfully"
    else
      flash[:danger] = "Your contact information was not saved. Please check all fields carefully and try again."
    end
      redirect_to user_path(current_user)
  end

  def update
    reset_primary_contact if contact_info_params[:primary]
    @contact_info = ContactInfo.find(params[:id])

    if @contact_info.update(contact_info_params)
      flash[:success] = "Your contact information was saved successfully"
    else
      flash[:danger] = "Your contact information was not saved. Please check all fields carefully and try again."
    end
      redirect_to user_path(current_user)
  end

  def destroy
    current_user.contact_infos.find(params[:id]).delete

    redirect_to user_path(current_user)
  end

  protected
    def reset_primary_contact
      current_user.contact_infos.each do |contact|
        contact.update_attributes(primary: false)
      end
    end

  private
    def contact_info_params
      params.require(:contact_info).permit(:first_name,
                                      :last_name,
                                      :title,
                                      :phone,
                                      :extension,
                                      :fax,
                                      :primary)
    end
end
