class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      log_in_user user.id
      flash[:notice] = "Welcome, #{user.username}!"
      redirect_to root_url
    else
      flash[:error] = "User not created!"
      redirect_to new_user_path
    end
  end

  def new
  end

  def edit
  end

  def update
    user = validate_user(params[:id], new_user_path)
    return if user.nil?

    if user.update_attributes(user_params)
      flash[:notice] = "Profile updated!"
      redirect_to root_url
    else
      flash[:error] = "Profile not updated!"
      redirect_to edit_user_path
    end
  end

  private
  def user_params
    params[:user][:ip] = request.remote_ip
    params.require(:user).permit(:username, :ip, :seat_id)
  end
end
