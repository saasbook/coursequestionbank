class InstructorController < ApplicationController

	def show
		@instructor = Instructor.find_by_id(session[:user_id])
		@collections = @instructor.collections
	end 
end
