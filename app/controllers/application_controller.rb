class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticated?
  
  helper_method :current_user

  def authenticated?
    # check user if already logged in - if not redirect to login page
    redirect_to login_path unless current_user
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
