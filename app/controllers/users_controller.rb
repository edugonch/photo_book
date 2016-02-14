class UsersController < ApplicationController

  def profile
    user = User.find(params[:id])
    @images = user.images.paginate(:page => params[:page], :per_page => 10)
  end

end
