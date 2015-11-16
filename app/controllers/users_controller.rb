class UsersController < ApplicationController
  before_action :go_to_index, only: [:new]

  def go_to_index
    if logged_in?
      redirect_to cats_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!
      redirect_to cats_url
    else
      render :new
    end

  end


  private
  def user_params
    params.require(:user).permit(:user_name, :password)

  end
end
