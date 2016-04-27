class ApplicationController < ActionController::Base
  protect_from_forgery
  #alias_method :current_user, :set_current_user

  before_filter :set_current_user

  protected # prevents method from being invoked by a route
  def set_current_user
    @current_user ||= Instructor.find_by_id(session[:user_id])
    redirect_to login_path and return unless @current_user
    authorize! :read, Problem
  end

  def current_ability
    @current_ability ||= Ability.new(@current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    if cannot? :read, Problem
    	flash[:notice] = "You don't have permission to access this site. Ask an administrator to be granted permission first."
    	session.delete(:user_id)
      redirect_to login_path
    else
      flash[:notice] = "You don't have permission to access this page."
      redirect_to request.referer.present? ? :back : problems_path
    end
  end


  def self.parse_list(string)
    string ? string.split(',').map(&:strip).reject(&:empty?) : []
  end

end
