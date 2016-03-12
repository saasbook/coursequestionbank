class ProblemsController < ApplicationController
  before_filter :set_filter_options
  load_and_authorize_resource
 @@defaults = HashWithIndifferentAccess.new({
   'search' => "", 
   'tags' => [], 
   'collections' => [], 
   'last_exported_begin' => nil, 'last_exported_end' => nil, 
   'per_page' => 60, 'page' => 1 })

  def set_filter_options
    session[:filters] ||= HashWithIndifferentAccess.new(@@defaults)

    @@defaults.each do |key, value|
      session[:filters][key] ||= value
    end
    
    session[:filters][:page] = nil
    session[:filters] = session[:filters].merge params.slice(:page, :per_page)
  end

  def set_filters
    session[:filters] = session[:filters].merge params.slice(:tags, :last_exported_begin, :last_exported_end, :search)
    
    if session[:filters][:tags].is_a? String
      session[:filters][:tags] = session[:filters][:tags].split(',').map(&:strip)
    end

    session[:filters][:collections] = []
    if params[:collections]
      params[:collections].each do |key, value|
          session[:filters][:collections] << Integer(key) if value == "1"
      end
    end
    if session[:filters][:collections].include?(0)
      session[:filters][:collections] = []
    end

    # if session[:filters][:last_exported_begin] and session[:filters][:last_exported_end].empty?
    #   session[:filters][:last_exported_begin] = nil
    # end
    # if session[:filters][:last_exported_end] and session[:filters][:last_exported_end].empty?
    #   session[:filters][:last_exported_end] = nil
    # end
    
    redirect_to problems_path
  end

  def home
      redirect_to problems_path
  end

  def index
    @collections = @current_user.collections
    @problems = Problem.filter(@current_user, session[:filters].clone)
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
  
  def add_tags
    problem = Problem.find(params[:id])
    tags = params[:add_tag_names].split(/\s*,\s*/)
    flash[:notice] = "Tags added" if problem.add_tags(tags)
    flash.keep
    redirect_to :back
  end
end