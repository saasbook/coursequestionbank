class UploadController < ApplicationController
  def upload
    authorize! :manage, Problem
    #TODO: Redirect to the loading page
    file = params[:ruql_file]
    @job_id = UploadWorker.perform_async(session[:user_id], file.path)
    session[:job_id] = @job_id
    flash[:notice] = "Uploading File..."
    flash.keep
    redirect_to loading_path
    return
  end
  #adopted from https://gist.github.com/kitwalker12/513d55721b787a160426
  def fetch
    job_id = session[:job_id]
    if Sidekiq::Status::complete? job_id
      flash[:notice] = "Upload successful!"
      render json: { success: true }
    elsif Sidekiq::Status::failed? job_id
      flash[:notice] = "Error Uploading File! Please try again..."
      render json: { success: false }
    else 
      render json: { status: :ok, processing: true }
    end
  end
end

=begin  **** LEGACY CODE ****
  def upload
    authorize! :manage, Problem
    begin
      collections, dups_found = RuqlReader.store_as_json(@current_user, params[:ruql_file])

      if dups_found
        flash[:notice] = "Near-duplicate questions may have been uploaded! See questions tagged with 'dup' and the new Question's UID. Click on tag to view potential matches. Mark undesired Questions as Obsolete. Remove dup tags when finished."
      end
    rescue Exception => e
      flash[:notice] = e.message()
      # flash[:notice] = e.backtrace()
      flash.keep
      redirect_to upload_path
      return
    end
    flash.keep
    redirect_to finalize_upload_path(:ids => collections.map{|collection| collection.id})
  end
end

# In upload
    # if collections.nil? || collections.empty?
    #   flash[:notice] = 'The file you uploaded does not contain any quizzes'
    #   flash.keep
    #   redirect_to upload_path
    #   return
    # end
=end
