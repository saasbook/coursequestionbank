class ApplicationController < ActionController::Base
  protect_from_forgery
  #alias_method :current_user, :set_current_user

  before_filter :set_current_user

  protected # prevents method from being invoked by a route
  def set_current_user
    @current_user ||= Instructor.find_by_id(session[:user_id])
    authorize! :manage, :all
    redirect_to login_path and return unless @current_user
  end

  def current_ability
    @current_ability ||= Ability.new(@current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
  	flash[:notice] = "You don't have persmission to access the site at the moment."
    redirect_to login_path, :alert => exception.message
  end

end
