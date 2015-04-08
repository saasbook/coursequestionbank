class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  def create
    auth = request.env["omniauth.auth"]
    user = Instructor.find_by_provider_and_uid(auth["provider"],auth["uid"]) ||
      Instructor.create_with_omniauth(auth)
    session[:user_id] = user.id
    if Rails.env.development?
      session[:user_id] = Instructor.find_by_uid("1234").id
    end
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
  end
end
