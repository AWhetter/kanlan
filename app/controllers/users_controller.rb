class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.username}!"
      redirect_to root_url
    else
      flash[:error] = "User not created!"
      redirect_to new_user_path
    end
  end

  def new
  end

  private
  def user_params
    params[:user][:ip] = request.remote_ip
    params.require(:user).permit(:username, :ip, :seat_id)
  end
end
