class CollectionsController < ApplicationController
  def new
    puts 'NEW CALLED'
    @collection = Collection.new

  end
  def edit
    @collection = Collection.find(params[:id])
  end
  # creates a new collection with user specified values and sets as current collection
  def create
    @collection = Collection.new params[:collection]
    @collection.instructor =  @current_user
    @collection.created_at = DateTime.now
    @collection.save
    @current_user.current_collection = @collection.id


    puts 'COLLECTION IS ', @current_user.current_collection
    @current_user.save
    
    puts 'collection created successfuly and entered into DB'
    redirect_to profile_path
  end



  # def swagger
  #   do work
  #   render json: {success: 'true'}

end
