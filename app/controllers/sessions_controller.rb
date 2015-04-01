class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  def create
    auth= request.env["omniauth.auth"]
    user= Employee.find_by_uid( auth["uid"] ) || Employee.create_on_first_login(auth)
    if ( user )
      session[:user_uid] = user.uid
      if user.admin
        redirect_to  employee_path(user)
      else
        redirect_to  welcome_index_path(user)
      end
    else
      flash[:notice] =  auth['info']['email'] + " is not registered to an employee "
      redirect_to '/login'
    end
  end

  def logout

  end

  def new
    render "sessions/login"
  end

  def destroy
    session.delete(:user_uid)
    flash[:notice] = 'Logged out successfully.'
    redirect_to "/login"
  end

  def fakelogin
    session[:user_uid] = params[:uid]
    redirect_to "/"
  end
end
