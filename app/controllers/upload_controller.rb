class UploadController < ApplicationController
  def upload
    authorize! :manage, Problem
    #TODO: Redirect to the loading page
    file = params[:ruql_file]
    UploadWorker.perform_async(session[:user_id], file.path)
    flash[:notice] = "Uploading File..."
    redirect_to loading_file_path
  end
end
