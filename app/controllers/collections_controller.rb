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
    Collection.create_collection(params[:collection], @current_user)
    redirect_to profile_path
  end
end
