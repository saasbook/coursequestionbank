class ProblemsController < ApplicationController

  def home
      redirect_to problems_path
  end

	def index
  		filter_options = params.slice(:tags, :collections, :last_exported_begin, :last_exported_end, :search)
      @problems = Problem.filter(@current_user, filter_options)
      @collections = @current_user.collections unless !@current_user
	end


  #eventually this will be an AJAX call
  def add_to_collection
    Collection.find(@current_user.current_collection).problems.push(Problem.find(params[:id]))
    flash[:notice] = 'problem added to #{@current_user.current_collection.name}'
    redirect_to problems_path
  end
    
end
