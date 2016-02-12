class UsersController < ApplicationController

  def profile
    user = User.find(params[:id])
    @images = user.images
  end

end
