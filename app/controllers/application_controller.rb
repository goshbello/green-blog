class ApplicationController < ActionController::Base

  helper_method :current_user  # make this method avialable to views and application_helper
  helper_method :logged_in?    # make this method avialable to views and application_helper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    if !logged_in?
      flash[:alert] = "You must login to perform that action"
      redirect_to login_path
    end
  end

end
