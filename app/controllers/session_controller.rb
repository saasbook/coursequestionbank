class SessionController < ApplicationController
  skip_before_filter :set_current_user

  def bypass
    session[:user_id] = params[:user_id]
    redirect_to problems_path
  end

  def create
    auth = request.env["omniauth.auth"]
    user = Instructor.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
             Instructor.create_via_omniauth(auth)
    session[:user_id] = user.id
    redirect_to problems_path
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to login_path
  end

  def failure
  	flash[:notice] = 'Authentication failed, please try again.'
  	flash[:notice] += params[:message] if params[:message]
  	redirect_to login_path
  end

  def login
    @dev_users = Instructor.dev_users
  end
end
