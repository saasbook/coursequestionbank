# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (CourseQuestionBank )?home\s?page$/ then '/problems'
    when /^the login page$/ then '/login'
    when /^the problems page$/ then '/problems'
    when /^the dashboard$/ then '/profile'
    when /^the upload page$/ then '/upload'
    when /^the admin panel$/ then '/admin'
    when /^the login page$/ then '/auth/bypass/5'
    when /^the page with more than sixty questions$/ then '/problems?per_page=100'
    when /^the collection search page$/ then '/collections' 
    when /^the collection index page$/ then '/collections' 
    when /^the collection search page of "(.*?)" $/ then '/collections' 

    when /^the finalize upload page$/ then '/finalize_upload'
    when /^the collection edit page$/ then  '/collections/1/edit'

    when(/^the export page$/) then '/collections/1/export'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
