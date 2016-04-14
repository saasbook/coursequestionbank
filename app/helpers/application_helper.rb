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
    if selected.nil?
      result += '<option selected disabled hidden style="display: none" value=""></option>'
    end
    options.each do |option|
      result += option == selected ? '<option selected>' : '<option>'
      result += option
      result += '</option>'
    end
    result.html_safe
  end
end
