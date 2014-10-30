class UsersController < ApplicationController
  
  before_action :require_not_signed_in_user, only: [:new, :create] ##this will need to change after more route methods are added
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def new
    @user = User.new
    render :new
  end
  
  def require_not_signed_in_user
    redirect_to cats_url if current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end
