class CollectionsController < ApplicationController
  load_and_authorize_resource
  after_filter :set_current_collection

  def set_current_collection
  end

  def new
    @collection = Collection.new
  end

  def edit
    @collection = Collection.find(params[:id])
    @problems = @collection.problems
  end

  # creates a new collection with user specified values and sets as current collection
  def create
    collection_hash = params[:collection]
    if not (collection = @current_user.collections.create(collection_hash)).valid?
      flash[:notice] =  collection.errors.messages.map {|key, value| key.to_s + ' ' + value.to_s}.join ' ,'
      flash.keep
    end
    redirect_to profile_path
  end

  def show
    @collection = Collection.find(params[:id])
    @problems = @collection.problems
  end

  def update
    if not (collection = Collection.update(params[:id], params[:collection])).valid?
      flash[:notice] =  collection.errors.messages.map {|key, value| key.to_s + ' ' + value.to_s}.join ' ,'
      flash.keep
    end
    redirect_to profile_path
  end

  def destroy
    Collection.find(params[:id]).destroy
    flash[:notice] = 'Collection deleted'
    flash.keep
    redirect_to profile_path
  end

  def export

    @html_code = Collection.find(params[:id]).export('Html5')

    begin
      @edx_code = Collection.find(params[:id]).export('EdXml')
    rescue RuntimeError
      @edx_code = 'EdX not available'
    end

    begin
      @autoqcm_code = Collection.find(params[:id]).export('AutoQCM')
    rescue RuntimeError
      @autoqcm_code = 'AutoQCM not available'
    end

    if not @html_code
      flash[:notice] = 'Cannot export an empty collection! Add some questions to your collection first!'
      flash.keep
      redirect_to edit_collection_path( id: params[:id])
    end
  end

  def finalize_upload
    @collections = params[:ids].map{|collection_id| Collection.find(collection_id)}
  end

  def flash_tag_added
    flash[:notice] = "Tags were added."
    flash.keep
  end

  def add_one_tag(cur_tags, tag)
    if !cur_tags.find_by_name(tag)
      cur_tags.create(name: tag)
      flash_tag_added
    end
  end

  def add_tags_to_problem(problem_id, new_tags)
    problem = Problem.find(problem_id)
    cur_tags = problem.tags
    if new_tags.length > 1 # multiple tags
        new_tags.each do |t|
          add_one_tag(cur_tags, t)
        end
    else # single tag
      add_one_tag(cur_tags, new_tags.first)
    end
    problem.save
  end

  def no_selection_error
    flash[:error] = "You need to select a problem."
    flash.keep
  end

  def no_tags_error
    flash[:error] = "You need to enter a tag."
    flash.keep
  end

  def update_multiple_tags
    new_tags = params[:tags][:names].split(/\s*,\s*/)
    selected = params[:problems]
    if params[:tags][:names] == ""
      no_tags_error
    elsif !selected
      no_selection_error
    elsif selected.class != Array
      add_tags_to_problem(selected, new_tags)
    elsif selected.length == 1
      add_tags_to_problem(selected.first, new_tags)
    elsif selected.length > 1
      selected.each do |problem_id|
        add_tags_to_problem(problem_id, new_tags)
      end
    end
    redirect_to :back
  end

  def checked_problems
    collection = Collection.find(params[:dropdown])
    collection_size = collection.problems.size
    if params['add_problems'] and params[:problems].present?
      if params[:problems].class == String
        update_multiple_tags
        return
      end
      params[:problems].each {|problem_id, value| collection.problems << Problem.find(problem_id)}
      flash[:notice] = "#{collection.problems.size - collection_size} of #{params[:problems].size } problems added to collection: #{collection.name}. If not all were added, you are trying to add a duplicate to the collection"
      flash.keep
    elsif params[:problems].present? #for delete route
      params[:problems].each {|problem_id, value| Problem.find(problem_id).destroy}
      flash[:notice] = 'Problems successfully deleted'
      flash.keep
    end
    redirect_to problems_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    redirect_to profile_path, :alert => exception.message
  end
end
