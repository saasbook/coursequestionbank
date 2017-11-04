class InstructorsController < ApplicationController

  def show
    session[:filters] = nil
    authorize! :manage, Collection
    @heading = 'Your collections'
    @instructor = Instructor.find_by_id(@current_user)
    @collections = @instructor.collections.to_a
    render :template => 'collections/index'
  end

  # def mark_as_current
  #   Instructor.update(@current_user.id, {:current_collection => params[:id]})
  #   redirect_to profile_path
  # end

  def admin
    authorize! :manage, Instructor
    # @unauthorized_users = Instructor.all.select{|i| i.privilege.nil?}
    @instructor = Instructor.order(:username)
  end

  def update_instructor
    authorize! :manage, Instructor
    username = params[:username] ? params[:username].strip : nil
    provider = params[:provider]
    privilege = params[:privilege]

    if username == @current_user.username and provider == @current_user.provider and privilege != @current_user.privilege
      flash[:error] = "Can't change your own privilege level"
      redirect_to :back and return
    end

    # if username == ''
    #   flash[:error] = 'Please enter a username.'
    #   redirect_to :back and return
    # elsif !Whitelist.providers.include?(provider)
    #   flash[:error] = 'Please select a provider.'
    #   redirect_to :back and return
    # elsif !Whitelist.privilege_levels.include?(privilege)
    #   flash[:error] = 'Please select a privilege level.'
    #   redirect_to :back and return
    # end

    instructor = Instructor.find_by_username_and_provider(username, provider)
    # if whitelist
    instructor.update_attribute(:privilege, privilege)
    instructor.touch
    # else
    #   Whitelist.create(:username => username, :provider => provider, :privilege => privilege)
    # end
    flash[:notice] = "#{instructor.username} is now #{instructor.get_privilege}."
    redirect_to :back
  end

  # def delete_whitelist_entry
  #   authorize! :manage, Instructor
  #   instructor = Instructor.find(params[:id])
  #
  #   if whitelist.username == @current_user.username and whitelist.provider == @current_user.provider
  #     flash[:error] = "Can't change your own privilege level"
  #     redirect_to :back and return
  #   end
  #
  #   whitelist.destroy
  #   flash[:notice] = 'Whitelist entry removed'
  #   redirect_to :back
  # end

  # def toggle_whitelist
  #   authorize! :manage, Whitelist
  #   Whitelist.is_enabled = !Whitelist.is_enabled
  #   flash[:notice] = Whitelist.is_enabled ? 'Whitelist enabled.' : 'Whitelist disabled.'
  #   redirect_to :back
  # end

end
