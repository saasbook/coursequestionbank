class CollectionsController < ApplicationController
  load_and_authorize_resource

  @@defaults = HashWithIndifferentAccess.new({'search' => ""})



  def new
    @collection = Collection.new
  end

  def index
    session[:filters] = nil
    @heading = 'Public collections'
    @instructor = Instructor.find_by_id(@current_user)

    if @current_user.get_privilege == "Student"
      @collections = Collection.where(:access_level => 1)
    else
      @collections = Collection.where(:access_level => 1) + Collection.where(:access_level => 2)
    end
    # debugger
  end

  def search
    session[:filter] ||= HashWithIndifferentAccess.new(@@defaults)
    session[:filter][:search] = params[:search]

    @search = session[:filter][:search]

    if @search.empty? || @collections.nil?
      redirect_to collections_path
    end

    @collections = Collection.filter(@current_user, session[:filter].clone)
  end

  def edit
    @collection = Collection.find(params[:id])
    @problems = @collection.problems
  end

  # creates a new collection with user specified values and sets as current collection
  def create
    collection = @current_user.collections.create
    collection.set_attributes(params)

    if not collection.valid?
      collection_errors(collection)
      redirect_to :back and return
    else
      collection.save
    end
    redirect_to collection_path(:id => collection.id)
  end

  def show
    @collection = Collection.find(params[:id])
    @problems = @collection.problems
  end

  def update

    collection = Collection.find(params[:id])
    collection.set_attributes(params)

    if not collection.valid?
      collection_errors(collection)
      redirect_to :back and return
    else
      if params[:access_level].nil? == false
        name = {"Public" => 1, "Share" => 2, "Private" => 3}
        level = name[params[:access_level]]
        collection.access_level = level
      end
      collection.save

    end
    redirect_to collection_path(:id => collection.id)
  end

  def destroy
    Collection.find(params[:id]).destroy
    flash[:notice] = 'Collection deleted'
    redirect_to profile_path
  end

  def export
    @collection = Collection.find(params[:id])

    @ruql_code = @collection.export('ruql') rescue "(error rendering RuQL)"
    @html_code = @collection.export('Html5') rescue "(error rendering HTML)"
    @edx_code = @collection.export('EdXml') rescue "(error rendering Edml)"
    @autoqcm_code = @collection.export('AutoQCM') rescue "(error rendering AutoQCM)"

    if not @html_code
      flash[:notice] = 'Cannot export an empty collection! Add some questions to your collection first!'
      redirect_to collection_path(:id => @collection.id)
    end
  end

  def preview
    ruql_code = Collection.find(params[:id]).export('ruql')
    render :text => ruql_code
  end

  def finalize_upload
    @collections = params[:ids].map{|collection_id| Collection.find(collection_id)}
    @collections.each{|c| authorize! :read, c}
  end

  private

  def collection_errors(collection)
    flash[:notice] =  collection.errors.messages.map {|key, value| key.to_s + ' ' + value.to_s}.join ' ,'
  end

end
