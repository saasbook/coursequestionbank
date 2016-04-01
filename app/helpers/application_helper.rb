module ApplicationHelper
  def user_display_name(user)
    if user.name and !user.name.empty?
      user.name
    else
      user.provider + ' user'
    end
  end
end
