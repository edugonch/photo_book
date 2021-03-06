class ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :delete]

  def index
    if params[:lat].present? && params[:lng].present?
      @images = Image.where(lat: params[:lat], lng: params[:lng]).paginate(:page => params[:page], :per_page => 10)
    end
  end

  def new
    @user = current_user
  end

  def search
    @images = Image.where("tags && '{#{params[:tags].join(',')}}'").paginate(:page => params[:page], :per_page => 10)
  end

  def create
    current_user.update_attributes(image_params)
    if current_user.save
      redirect_to profile_path(current_user.id)
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
