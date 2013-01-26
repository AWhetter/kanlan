class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:username], request.remote_ip)
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Hello again, " + params[:username] + "!"
    elsif User.find_by_username(params[:username]).nil?
      flash.now[:notice] = "No user exists with that username. Please sign up."
      render "new"
    else
      flash.now[:notice] = "Invalid username for this IP address!"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
