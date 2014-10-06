class UsersController < ApplicationController
	def tooltip
		@user_info = SteamInfo::UserInfo::get([params[:uid]], :simple_status_str, :in_game, :playing, :image, :profile_url, :username)[params[:uid]]

		render layout: false
	end

	def signup_from_steam
		if session["devise.steam_data"].nil?
			redirect_to user_omniauth_authorize_path(:steam)
			return
		elsif user_signed_in?
			notice[:warn] = "Already signed up!"
			redirect_to root_path
			return
		end

		@user = User.from_omniauth(session["devise.steam_data"])
		@user.table = params[:user][:table]
		@user.seat = params[:user][:seat]
		if @user.save
			sign_in_and_redirect @user
		else
			render user_omniauth_callback_path, action: :steam
		end
	end
end
