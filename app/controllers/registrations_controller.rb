class RegistrationsController < Devise::RegistrationsController
	def update
		account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

		# Required for settings form to submit when password is left blank
		if account_update_params[:password].blank?
			account_update_params.delete("password")
			account_update_params.delete("password_confirmation")
		end

		@user = User.find(current_user.id)

		successfully_updated = if @user.provider == "steam"
			account_update_params.delete(:current_password)
			@user.update_without_password(account_update_params)
		else
			@user.update_with_password(account_update_params)
		end

		if successfully_updated
			set_flash_message :notice, :updated
			# Sign in the user bypassing validation in case their password changed
			sign_in @user, :bypass => true
			redirect_to after_update_path_for(@user)
		else
			render "edit"
		end
	end
end
