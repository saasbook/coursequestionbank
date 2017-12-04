class UploadController < ApplicationController
  def upload
    authorize! :manage, Problem
    file = params[:ruql_file]
    @job_id = UploadWorker.perform_async(session[:user_id], file.path)
    session[:job_id] = @job_id
    flash[:notice] = "Uploading File..."
    flash.keep
    redirect_to loading_path
    return
  end
  def fetch
    job_id = session[:job_id]
    user = Instructor.find_by_id(session[:user_id])
    msg = ""
    if Sidekiq::Status::complete? job_id
      if user.uploaded_duplicates
         msg = "Identical questions may have been uploaded! See questions tagged with 'dup' and the new Question's UID. Mark undesired Questions as Obsolete. Remove dup tags when finished."
      elsif user.uploaded_same_file
        msg = 'Quiz with that name already exists in your list of collections. You probably did not mean to upload the same quiz again. Try deleting the old collection and upload again if you really meant to do that.'
      elsif user.uploaded_empty_file
        msg = "The file you uploaded does not contain any quizzes. Please try uploading another file..."
      else
        msg = "Upload Successful!"
      end
      flash[:notice] = msg
      flash.keep
      session[:job_id] = nil
      render json: {success: true, dups_found: user.uploaded_duplicates, same_file: user.uploaded_same_file, empty_file: user.uploaded_empty_file, collection_id: user.current_collection}
    elsif Sidekiq::Status::failed? job_id
      flash[:notice] = "Error Uploading File! Please try again..."
      flash.keep
      session[:job_id] = nil
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
