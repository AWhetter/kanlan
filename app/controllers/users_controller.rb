class UsersController < ApplicationController
  def new
    @user = User.new
    @user.id = request.remote_ip.gsub('.', '').to_i
  end

  def create
    params[:user][:id] = request.remote_ip.gsub('.', '').to_i
    @user = User.new(params[:user])

    if User.exists?(@user.id)
      flash.now[:notice] = "You have already registered from this ip address"
      render "new"
    elsif @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Welcome, " + @user.username + "!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])

    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Profile updated!"
    else
      render "edit"
    end
  end
end
