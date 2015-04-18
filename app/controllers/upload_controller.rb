class UploadController < ApplicationController

  def upload
    begin 
      collections = RuqlReader.store_as_json(@current_user, params[:ruql_file])
    rescue Exception => e
      flash[:notice] = "There is an error in the file: " + e.message
      flash.keep
      redirect_to upload_path
      return
    end
    if collections.nil? || collections.empty?
      flash[:notice] = 'The file you uploaded does not contain any quizzes'
      flash.keep
      redirect_to upload_path
      return
    end
    flash.keep
    redirect_to finalize_upload_path(:ids => collections.map{|collection| collection.id})
  end
end
