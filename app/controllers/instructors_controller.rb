class InstructorsController < ApplicationController

  def show
    @instructor = Instructor.find_by_id(@current_user)
    @collections = @instructor.collections
  end

  def mark_as_current
    Instructor.update(@current_user.id, {:current_collection => params[:id]})
    redirect_to profile_path
  end

end
