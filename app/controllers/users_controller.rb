class UsersController < ApplicationController
	def tooltip
		@user_info = SteamInfo::UserInfo::get([params[:uid]], :simple_status_str, :in_game, :playing, :image, :profile_url, :username)[params[:uid]]

		render layout: false
	end
end
