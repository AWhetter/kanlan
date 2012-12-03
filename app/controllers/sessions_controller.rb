class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:username], request.remote_ip.gsub('.', '').to_i)
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Hello again, " + params[:username] + "!"
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
