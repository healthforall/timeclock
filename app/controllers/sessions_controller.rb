class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  def create
    auth= request.env["omniauth.auth"]
    user= Employee.find_by_uid( auth["uid"] ) || Employee.create_with_omniauth(auth)
    session[:user_id] = user.uid
    redirect_to  employees_path
  end

  def logout

  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to root_path
  end
end
