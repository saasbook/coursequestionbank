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
   'per_page' => 10, 'page' => 1 })

  def set_filter_options
    session[:filters] ||= HashWithIndifferentAccess.new(@@defaults)

    @@defaults.each do |key, value|
      session[:filters][key] ||= value
    end

    session[:filters][:page] = nil
    if (params[:per_page]) and (params[:per_page].to_i > 60)
        flash[:notice] = "Cannot view more than 60 questions at a time"
    else
      session[:filters] = session[:filters].merge params.slice(:page, :per_page) 
    end
  end

  def set_filters

    session[:filters] = session[:filters].merge params.slice(:search, :tags, :sort_by)

    if session[:filters][:tags].is_a? String
      session[:filters][:tags] = self.class.parse_list session[:filters][:tags]
    end

    ["problem_type", "bloom_category"].each do |sub|
      session[:filters]["#{sub}"] = []
      if params["#{sub}"]
          params["#{sub}"].each do |key, value|
              session[:filters]["#{sub}"] << key if value == "1"
          end
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
    # debugger
    if can? :manage, Collection and @current_user.collections
      @collections = @current_user.collections + Collection.where(:access_level => 2) + Collection.where(:access_level => 3)
    else
      @collections = Collection.where(:access_level => 3)
    end
    # @is_student = cannot? :manage Collections

    @problems = Problem.filter(@current_user, session[:filters].clone, Problem.find_by_id(flash[:bump_problem]))
    # debugger
  end

  def new
    @ruql_source = flash[:ruql_source]
  end

  def create
    parent_uid = params[:parent_uid]
    if parent_uid
      previous_version = Problem.find_by_uid(params[:parent_uid])
      if !previous_version
        flash[:error] = "Could not find #{params[:parent_uid]}, using default previous question"
      end
    end

    privacy = params[:privacy] ? params[:privacy].strip.downcase : nil
    category = Problem.all_bloom_categories.include?(params[:category]) ? params[:category] : nil
    collections = []
    if params[:collections]
      params[:collections].each do |key, _|
        col = Collection.find(key)
        authorize! :manage, col
        collections << col
      end
    end

    begin
      problem = RuqlReader.read_problem(@current_user, params[:ruql_source])
      problem.previous_version = previous_version
      problem.is_public = privacy == 'public'
      problem.access_level = 1
      problem.bloom_category = category
      problem.save
      problem.add_tags(self.class.parse_list params[:tag_names])
      collections.each {|c| c.problems << problem}
      flash[:bump_problem] = problem.id
      Problem.reindex
      Sunspot.commit
      dups_found = Problem.handle_dups(@current_user, problem.id) #check for dups
      if dups_found
        flash[:notice] = "Near-duplicate question may have been uploaded! See questions tagged with 'dup' and the new Question's UID. Click on tag to view potential matches. Mark undesired Questions as Obsolete. Remove dup tags when finished."
      end

    rescue Exception => e
      if request.xhr?
        render :json => {'error' => e.message}
      else
        flash[:error] = "Error in problem source: #{e.message}. A Question's unique ID may already exist in database."
        flash[:ruql_source] = params[:ruql_source]
        redirect_to :back
      end
      return
    end

    flash[:notice] = "Question created." if !flash[:notice]
    if request.xhr?
      render :json => {'error' => nil}
    else
      redirect_to problems_path
    end
  end

  def update
    problem = Problem.find(params[:id])

    if !update_privacy(problem)
      return
    end
    update_obs(problem)
    update_category(problem)
    update_collection(problem)
    update_previous(problem)
    problem.save

    flash_xhr(:bump_problem, problem.id)
    if request.xhr?
      render :nothing => true
    else
      redirect_to :back
    end
  end

  def flash_xhr(type, message)
    if !request.xhr?
      flash[type] = message
    end
  end
  
  def update_privacy(problem)
    if !params[:privacy].nil?
      authorize! :set_privacy, problem
      privacy = params[:privacy].downcase.strip
      priv_map = {'public' => 2, 'share' => 3, 'private' => 1}
      if priv_map.key?(privacy)
        problem.access_level = priv_map[privacy]
      else
        return false
      end
      flash_xhr(:notice, "Problem changed to #{privacy}")
    end
    return true
  end
    
  def update_obs(problem)
    if !params[:obsolete].nil?
      authorize! :set_obsolete, problem
      problem.obsolete = params[:obsolete] == '1'
      flash_xhr(:notice, "Problem marked as #{'not ' if !problem.obsolete}obsolete")
    end
  end  
    
  def update_category(problem)
    if !params[:category].nil?
      authorize! :bloom_categorize, problem
      category = params[:category].downcase.strip
      category[0] = category[0].upcase
      if Problem.all_bloom_categories.include? category
        problem.bloom_category = category
        flash_xhr(:notice, "Bloom category set to #{category}")
      elsif category == 'None'
        problem.bloom_category = nil
        flash_xhr(:notice, "Bloom category removed")
      end
    end
  end
  
  def update_collection(problem)
    if !params[:collection].nil?
      target_collection = Collection.find(params[:collection])
      if !target_collection.problems.include? problem
        authorize! :add_problems, target_collection
        target_collection.problems << problem
        flash_xhr(:notice, "Problem added to #{target_collection.name}")
      else
        authorize! :remove_problems, target_collection
        target_collection.problems.delete(problem)
        flash_xhr(:notice, "Problem removed from #{target_collection.name}")
      end
    end
  end
  
  def update_previous(problem)
    if !params[:previous].nil?
        authorize! :set_previous, problem
        previous = Problem.find_by_uid(params[:previous])
        if previous
          problem.previous_version = previous
          flash_xhr(:notice, "Problem parent set to #{params[:previous]}")
        else
          flash_xhr(:error, "Problem #{params[:previous]} not found")
        end
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

  def view_tags
    session[:filters] = HashWithIndifferentAccess.new(@@defaults)
    @@defaults.each do |key, value|
      session[:filters][key] = value
    end

    session[:filters][:tags] = self.class.parse_list params[:tag_names]
    redirect_to problems_path
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

  def minorupdate
    @problem = Problem.find(params[:id])
    @ruql_source = flash[:ruql_source]
  end

  def supersede
    @problem = Problem.find(params[:id])
    @ruql_source = flash[:ruql_source]
  end

  def view_history
    @problem = Problem.find(params[:id])
    @history = @problem.history
  end

  def edit_minor

    new_problem = RuqlReader.read_problem(@current_user, params[:ruql_source])
    original_problem = Problem.find_by_uid(params[:parent_uid])

    if !new_problem[:json].nil?
      if original_problem[:json] != new_problem[:json]
        original_problem[:json] = new_problem[:json]
        original_problem.save

        flash[:notice] = "Question updated."
      else
        flash[:notice] = "Nothing changes."
      end

    end

    if request.xhr?
      render :json => {'error' => nil}
    else
      redirect_to problems_path
    end

  end

end