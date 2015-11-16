class SessionsController < ApplicationController
  before_action :go_to_index, only: [:new]

  def go_to_index
    if logged_in?
      redirect_to cats_url
    end
  end
  
  def new
    render :new
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  def create
    @user = User.find_by(user_name: params[:user][:user_name])
    if @user.nil?
      render :new
    else
      log_in!
      redirect_to cats_url

    end
  end
end
