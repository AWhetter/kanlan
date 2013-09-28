class SessionsController < ApplicationController
  def new
    if not current_user.nil?
      flash[:error] = "Already logged in!"
      redirect_to root_url
    end
  end

  def create
    if not current_user.nil?
      flash[:error] = "Already logged in!"
      redirect_to root_url
      return
    end

    user = User.find_by_username(params[:username])
    if user.nil?
      flash.now[:error] = "Invalid username."
      render :new
      return
    end

    if not user.authenticate?(request.remote_ip)
      flash.now[:error] = "Invalid ip."
      render :new
    else
      log_in_user(user.id)
      flash[:notice] = "Logged in!"
      redirect_to root_url
    end
  end

  def destroy
    log_out_user
    flash[:notice] = "Logged out!"
    redirect_to root_url
  end
end
