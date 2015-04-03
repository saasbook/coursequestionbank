class CollectionsController < ApplicationController
  def new
    puts 'NEW CALLED'
    @collection = Collection.new

  end
  def edit
    @collection = Collection.find(params[:id])
  end

  def create
    @collection = Collection.new params[:collection]
    @collection.instructor =  @current_user
    @collection.created_at = DateTime.now
    @collection.save
    puts 'collection created successfuly and entered into DB'
  end

end
