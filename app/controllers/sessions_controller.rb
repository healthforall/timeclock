class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  def create
    auth=request.env["omniauth.auth"]
    user= Employee.find_by_provider_and_uid(auth["provider"],auth["uid"]) ||
          Employee.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to  employees_path
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
  end
end
