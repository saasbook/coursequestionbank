class InstructorsController < ApplicationController

  def show
    authorize! :manage, Collection
    @instructor = Instructor.find_by_id(@current_user)
    @collections = @instructor.collections.to_a
  end

  # def mark_as_current
  #   Instructor.update(@current_user.id, {:current_collection => params[:id]})
  #   redirect_to profile_path
  # end

  def admin
    authorize! :manage, Whitelist
    # @unauthorized_users = Instructor.all.select{|i| i.privilege.nil?}
    @whitelist = Whitelist.order(:updated_at).reverse
  end
  
  def update_whitelist
    authorize! :manage, Whitelist
    username = params[:username] ? params[:username].strip : nil
    provider = params[:provider] ? params[:provider].strip : nil
    privilege = params[:privilege] ? params[:privilege].strip : nil
    whitelist = Whitelist.find_by_username_and_provider(username, provider)
    if whitelist
      whitelist.update_attribute(:privilege, privilege)
      whitelist.touch
    else
      Whitelist.create(:username => username, :provider => provider, :privilege => privilege)
    end
    flash[:notice] = 'Whitelist entry updated.'
    redirect_to :back
  end

end
