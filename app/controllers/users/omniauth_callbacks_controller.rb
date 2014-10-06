class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	# This is the only spot where we allow CSRF, our openid / oauth redirect
	# will not have a CSRF token, however the payload is all validated so its safe
	skip_before_filter :verify_authenticity_token

	def steam
		if user_signed_in?
			current_user.link_omniauth(request.env["omniauth.auth"])
			redirect_to after_sign_in_path_for(current_user), notice: "Successfully merged with steam account!"
			return
		end

		@user = User.from_omniauth(request.env["omniauth.auth"].except(:extra))
		if @user.persisted?
			sign_in_and_redirect @user
			set_flash_message(:notice, :success, :kind => "Steam") if is_navigational_format?
		else
			@user_info = SteamInfo::UserInfo::get_from_info_hash(request.env["omniauth.auth"][:extra][:raw_info], :simple_status_str, :image, :username, :profile_url)
			session["devise.steam_data"] = request.env["omniauth.auth"].except(:extra)
		end
	end
end
