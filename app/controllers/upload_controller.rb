class UploadController < ApplicationController

  def upload
    puts params[:ruql_file]
    if RuqlReader.read_ruql(params[:ruql_file])
      flash[:notice] = "Sucessfully uploaded file"
      flash.keep
      redirect_to problems_path 
    else
      flash[:notice] = "problem occured in uploading"
      flash.keep 
      redirect_to upload_path
    end
    
  end
end