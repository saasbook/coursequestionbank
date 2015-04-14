class CollectionsController < ApplicationController
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
      flash[:notice] =  collection.errors.join ' ,'
      flash.keep
    end
    redirect_to profile_path
  end

  def update
    if not (collection = Collection.update(params[:id], params[:collection])).valid?
      flash[:notice] =  collection.errors.join ' ,'
      flash.keep
    end
    redirect_to profile_path
  end

end
