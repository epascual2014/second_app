class UsersController < ApplicationController
  
  def user_params
    params.require(:user).permit(:name, :avatar, :email_favorites)
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.visible_to(current_user)
  end
end
