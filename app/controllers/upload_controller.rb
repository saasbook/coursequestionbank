class UploadController < ApplicationController

  def upload
    authorize! :manage, Problem
    begin
      collections, dups_found = RuqlReader.store_as_json(@current_user, params[:ruql_file])
      if dups_found
        flash[:notice] = "Near-duplicate questions may have been uploaded! See questions tagged with 'dup' and the new Question's UID. Click on tag to view potential matches. Mark undesired Questions as Obsolete. Remove dup tags when finished."
      end
    rescue Exception => e
      flash[:notice] = "There is an error in the file: " + e.message
      flash.keep
      redirect_to upload_path
      return
    end
    # if collections.nil? || collections.empty?
    #   flash[:notice] = 'The file you uploaded does not contain any quizzes'
    #   flash.keep
    #   redirect_to upload_path
    #   return
    # end
    flash.keep
    redirect_to finalize_upload_path(:ids => collections.map{|collection| collection.id})
  end
end
