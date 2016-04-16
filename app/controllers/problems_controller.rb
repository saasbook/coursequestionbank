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
   'show_obsolete' => false,
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

    session[:filters][:show_obsolete] = params[:show_obsolete] == "1"

    redirect_to problems_path
  end

  def home
      redirect_to problems_path
  end

  def index
    @collections = @current_user.collections
    @problems = Problem.filter(@current_user, session[:filters].clone, Problem.find_by_id(flash[:bump_problem]))
  end

  def new
    @ruql_source = flash[:ruql_source]
  end

  def create
    previous_version = Problem.find_by_id(params[:previous_version])
    privacy = params[:privacy] ? params[:privacy].strip.downcase : nil

    begin
      problem = RuqlReader.read_problem(@current_user, params[:ruql_source])
      problem.previous_version = previous_version
      problem.is_public = privacy == 'public'
      problem.bloom_category = previous_version.bloom_category if previous_version
      problem.save
      problem.add_tags(self.class.parse_list params[:tag_names])
      flash[:bump_problem] = problem.id

    rescue Exception => e
      if request.xhr?
        render :json => {'error' => e.message}
      else
        flash[:error] = "Error in problem source: #{e.message}"
        flash[:ruql_source] = params[:ruql_source]
        redirect_to :back
      end
      return
    end

    flash[:notice] = "Question created"
    if request.xhr?
      render :json => {'error' => nil}
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

    if !params[:obsolete].nil?
      authorize! :set_obsolete, problem
      problem.obsolete = params[:obsolete] == '1'
      problem.save
      flash[:notice] = "Problem marked as #{'not ' if !problem.obsolete}obsolete" if !request.xhr?
    end

    if !params[:category].nil?
      authorize! :bloom_categorize, problem
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

    if !params[:collection].nil?
      target_collection = Collection.find(params[:collection])
      if !target_collection.problems.include? problem
        authorize! :add_problems, target_collection
        target_collection.problems << problem
        flash[:notice] = "Problem added to #{target_collection.name}" if !request.xhr?
      else
        authorize! :remove_problems, target_collection
        target_collection.problems.delete(problem)
        flash[:notice] = "Problem removed from #{target_collection.name}" if !request.xhr?
      end
      problem.save
    end

    if request.xhr?
      render :nothing => true
    else
      flash[:bump_problem] = problem.id
      redirect_to :back
    end
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
    if request.xhr?
      render :nothing => true
    else
      flash[:notice] = "Tags removed"
      flash[:bump_problem] = problem.id
      redirect_to :back
    end
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

  def view_history
    @problem = Problem.find(params[:id])
    @history = @problem.history
  end
end
