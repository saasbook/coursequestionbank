class InstructorController < ApplicationController
	def new 
		render(:file => File.join(Rails.root, 'app/views/403.html'), :status => 403, :layout => false)
	end

	def show
		@instructor = Instructor.find_by_id(session[:user_id])
		@collections = @instructor.collections
	end 
end
