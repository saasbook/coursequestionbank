class InstructorController < ApplicationController

def new 
	render(:file => File.join(Rails.root, 'app/views/403.html'), :status => 403, :layout => false)
end
end
