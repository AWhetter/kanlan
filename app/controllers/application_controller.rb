class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?

	def authenticate_admin_user!
		authenticate_user!
		unless user_signed_in? and current_user.admin?
			flash[:alert] = "That area is restricted to administrators only!"
			redirect_to root_path
		end
	end

	def current_admin_user
		return nil unless user_signed_in? and current_user.admin?
		current_user
	end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :password, :password_confirmation, :remember_me) }
		devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :password, :remember_me) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :password, :password_confirmation, :current_password) }
	end

	def save_and_redirect(resource, success_msg='Success.', redirect_path=root_path)
		respond_to do |format|
			if resource.save
				format.html { redirect_to redirect_path, notice: success_msg }
				format.json { render nothing: true, status: :created }
			else
				format.html { render :new }
				format.json { render json: resource.errors, status: :unprocessable_entity }
			end
		end
	end
end
