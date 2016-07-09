class InstructorsController < ApplicationController

  def show
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
    authorize! :manage, Whitelist
    # @unauthorized_users = Instructor.all.select{|i| i.privilege.nil?}
    @whitelist = Whitelist.order(:username)
  end
  
  def update_whitelist
    authorize! :manage, Whitelist
    username = params[:username] ? params[:username].strip : nil
    provider = params[:provider]
    privilege = params[:privilege]
    
    if username == @current_user.username and provider == @current_user.provider and privilege != @current_user.privilege
      flash[:error] = "Can't change your own privilege level"
      redirect_to :back and return
    end
    
    if username == ''
      flash[:error] = 'Please enter a username.'
      redirect_to :back and return
    elsif !Whitelist.providers.include?(provider)
      flash[:error] = 'Please select a provider.'
      redirect_to :back and return
    elsif !Whitelist.privilege_levels.include?(privilege)
      flash[:error] = 'Please select a privilege level.'
      redirect_to :back and return
    end
    
    whitelist = Whitelist.find_by_username_and_provider(username, provider)
    if whitelist
      whitelist.update_attribute(:privilege, privilege)
      whitelist.touch
    else
      Whitelist.create(:username => username, :provider => provider, :privilege => privilege)
    end
    flash[:notice] = 'Whitelist updated.'
    redirect_to :back
  end
  
  def delete_whitelist_entry
    authorize! :manage, Whitelist
    whitelist = Whitelist.find(params[:id])
    
    if whitelist.username == @current_user.username and whitelist.provider == @current_user.provider
      flash[:error] = "Can't change your own privilege level"
      redirect_to :back and return
    end
    
    whitelist.destroy
    flash[:notice] = 'Whitelist entry removed'
    redirect_to :back
  end
  
  def toggle_whitelist
    authorize! :manage, Whitelist
    Whitelist.is_enabled = !Whitelist.is_enabled
    flash[:notice] = Whitelist.is_enabled ? 'Whitelist enabled.' : 'Whitelist disabled.'
    redirect_to :back
  end

end
