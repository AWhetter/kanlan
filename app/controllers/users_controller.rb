class UsersController < ApplicationController
  def new
    @user = User.new
    @user.ip = request.remote_ip
  end

  def create
    params[:user][:ip] = request.remote_ip
    @user = User.new(params[:user])

    if User.exists?(:ip => @user.ip)
      flash.now[:notice] = "You have already registered from this ip address"
      render "new"
    elsif SEATS[params[:user][:table]].include?(params[:user][:seat])
      flash.now[:notice] = "Seat is not on selected table"
      render "edit"
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

    if not SEATS[params[:user][:table]].include?(params[:user][:seat])
      flash.now[:notice] = "Seat is not on selected table"
      render "edit"
    elsif @user.update_attributes(params[:user]) and
      redirect_to root_url, :notice => "Profile updated!"
    else
      render "edit"
    end
  end
end
