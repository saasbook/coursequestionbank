class UploadController < ApplicationController

  def upload
    #begin 
      RuqlReader.store_as_json(@current_user, params[:ruql_file])
      flash[:notice] = "Sucessfully uploaded file"
      flash.keep
      redirect_to problems_path 
    #rescue Exception => e 
    #  flash[:notice] = "There is an error in the file: " + e.message
    #  flash.keep
    #  redirect_to upload_path 
    #end
  end
end
