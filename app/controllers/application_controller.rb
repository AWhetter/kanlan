class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_in_user(user_id)
    session[:user_id] = user_id
  end

  def log_out_user
    session[:user_id] = nil
  end

  def validate_logged_in_user(redirect_url)
    validate_user(session[:user_id], redirect_url)
  end

  def validate_user(user_id, redirect_url)
    begin
      return User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      log_out_user
      flash[:error] = "Invalid user logged in!"
      redirect_to redirect_url
      return nil
    end
  end
end
