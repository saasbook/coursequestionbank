class ProblemsController < ApplicationController
  before_filter :set_filter_options
  load_and_authorize_resource
 @@defaults = HashWithIndifferentAccess.new({
   'search' => "",
   'tags' => [],
   'sort_by' => 'Relevancy',
   'problem_type' => [],
   'collections' => [],
   'bloom_category' => [],
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
    session[:filters] = session[:filters].merge params.slice(:search, :tags, :sort_by)

    if session[:filters][:tags].is_a? String
      session[:filters][:tags] = self.class.parse_list session[:filters][:tags]
    end

    session[:filters][:problem_type] = []
    if params[:problem_type]
      params[:problem_type].each do |key, value|
          session[:filters][:problem_type] << key if value == "1"
      end
    end
    
    session[:filters][:bloom_category] = []
    if params[:bloom_category]
      params[:bloom_category].each do |key, value|
          session[:filters][:bloom_category] << key if value == "1"
      end
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

    redirect_to problems_path
  end

  def home
      redirect_to problems_path
  end

  def index
    @collections = @current_user.collections
    @problems = Problem.filter(@current_user, session[:filters].clone, Problem.find_by_id(flash[:bump_problem]))
  end

  def create
    if params[:previous_version] != nil
      previous_version = Problem.find(params[:previous_version])

      begin
        flash[:bump_problem] = previous_version.supersede(@current_user, params[:ruql_source])

      rescue Exception => e
        if request.xhr?
          render json: {'error' => e.message}
        else
          flash[:error] = "Error in problem source: #{e.message}"
          flash[:ruql_source] = params[:ruql_source]
          flash.keep
          redirect_to :back
        end
        return
      end
    end

    flash[:notice] = "Question created"
    if request.xhr?
      render json: {'error' => nil}
    else
      redirect_to problems_path
    end
  end
  
  def update
    problem = Problem.find(params[:id])
    
    if !params[:privacy].nil?
      authorize! :set_privacy, problem
      privacy = params[:privacy].downcase.strip
      if privacy == 'public'
        problem.is_public = true
      elsif privacy == 'private'
        problem.is_public = false
      else
        return
      end
      problem.save
      flash[:notice] = "Problem changed to #{privacy}" if !request.xhr?
    end
    
    if !params[:category].nil?
      category = params[:category].downcase.strip
      category[0] = category[0].upcase
      if Problem.all_bloom_categories.include? category
        problem.bloom_category = category
        flash[:notice] = "Bloom category set to #{category}" if !request.xhr?
      elsif category == 'None'
        problem.bloom_category = nil
        flash[:notice] = "Bloom category removed" if !request.xhr?
      end
      problem.save
    end
    
    flash[:bump_problem] = problem.id if !request.xhr?
    redirect_to :back
  end

  def add_tags
    problem = Problem.find(params[:id])
    tags = self.class.parse_list params[:tag_names]
    added = problem.add_tags(tags)
    if request.xhr?
      render :partial => "tags", locals: { problem: problem }
    else
      flash[:notice] = "Tags added" if added.size > 0
      flash[:bump_problem] = problem.id
      redirect_to :back
    end
  end

  def remove_tags
    problem = Problem.find(params[:id])
    tags = self.class.parse_list params[:tag_names]
    tags.each { |tag| problem.remove_tag tag }
    if !request.xhr?
      flash[:notice] = "Tags removed"
      flash[:bump_problem] = problem.id
    end
    redirect_to :back
  end
  
  def update_multiple_tags
    new_tags = self.class.parse_list params[:tag_names]
    selected = params[:checked_problems] ? params[:checked_problems].keys : []
    if new_tags == []
      flash[:error] = "You need to enter a tag."
    elsif selected == []
      flash[:error] = "You need to select a problem."
    else
      selected.each do |problem_id|
        problem = Problem.find(problem_id)
        authorize! :add_tags, problem
        flash[:notice] = "Tags were added." if problem.add_tags(new_tags).size > 0
      end
    end
    redirect_to :back
  end
  
  def supersede
    @problem = Problem.find(params[:id])
    @ruql_source = flash[:ruql_source]
  end
  
  def history
    @problem = Problem.find(params[:id])
    @history = @problem.history
  end
end
