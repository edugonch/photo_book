class ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :delete]

  def index
    if params[:lat].present? && params[:lng].present?
      @images = Image.where(lat: params[:lat], lng: params[:lng])
    end
  end

  def new
    @user = current_user
    puts @user.to_json
  end

  def create
    current_user.update_attributes(image_params)
    if current_user.save
      redirect_to users_profile_path
    else
      @user = current_user
      render 'new'
    end
  end

  def delete
  end
private
  def image_params
      params.require(:user).permit(images_attributes: [ :id, :file, :lat, :lng, :description, [:tags => []] ])
    end
end
