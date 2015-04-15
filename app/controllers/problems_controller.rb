class ProblemsController < ApplicationController

  def home
      redirect_to problems_path
  end

	def index
    if @current_user
      @collections = @current_user.collections
    else
      @collections = []
    end
    
    @chosen_collections = @collections.map { |c| c.name }
    if params[:collections]
      @chosen_collections = params[:collections].keys
    end
    
		filter_options = params.slice(:tags, :collections, :last_exported_begin, :last_exported_end, :search)

    @problems = Problem.filter(@current_user, filter_options)
	end


  #eventually this will be an AJAX call
  def add_to_collection
    Collection.find(@current_user.current_collection).problems.push(Problem.find(params[:id]))
    flash[:notice] = 'problem added to #{@current_user.current_collection.name}'
    redirect_to problems_path
  end
    
end
