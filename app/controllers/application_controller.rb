class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_current_user

  protected
    def set_current_user
      @current_user ||= Employee.find_by_uid(session[:user_id])
      render :partial =>'sessions/login'  and return unless @current_user
    end
end
