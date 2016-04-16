module ApplicationHelper
  def user_display_name(user)
    if user.name and !user.name.empty?
      user.name
    else
      user.provider + ' user'
    end
  end
  
  def options(options, selected=nil)
    result = ""
    if !options.include?(selected)
      result += "<option selected disabled hidden>#{selected}</option>"
    end
    options.each do |option|
      result += option == selected ? '<option selected>' : '<option>'
      result += option
      result += '</option>'
    end
    result.html_safe
  end
  
  def privacy_options(is_public)
    options(['Public', 'Private'], is_public ? 'Public' : 'Private')
  end
end
