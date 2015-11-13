class SessionsController < ApplicationController

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
