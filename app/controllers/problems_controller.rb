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

  #eventually this will be an AJAX call. ALSO WE NEED TO CHANGE OUR HABTM ASSOCIATION TO HAS_MANY: THROUGH SO WE CAN USE VALIDATIONS AND STUFF
  def add_to_collection
    collection = Collection.find(params[:collection_id])
    if not collection
      render :json => {:status => false}
      return
    end
    problem_to_add = Problem.find(params[:id])
    if not collection.problems.include? problem_to_add  
      collection.problems << problem_to_add
      render :json => {:status => true}
    else 
      render :json => {:status => false}
    end
  end

  def remove_from_collection
    collection = Collection.find(params[:collection_id])
    problem_to_remove = Problem.find(params[:id])
    if collection.problems.include? problem_to_remove
      collection.problems.delete(problem_to_remove)
      collection.save
      flash[:notice] = "problem successfully removed from #{collection.name}"
    else 
      flash[:notice] = "the problem you attempted to remove does not exist in #{collection.name}"
    end
    flash.keep
    redirect_to edit_collection_path(:id => collection.id)
  end
end
