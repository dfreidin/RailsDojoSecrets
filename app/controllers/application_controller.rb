class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_logged_in
    redirect_to "/sessions/new" unless session.include?(:user_id)
  end
  before_action :authenticate_logged_in

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
