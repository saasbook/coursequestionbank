class ProblemsController < ApplicationController

    def home
        redirect_to problems_path
    end

	def index
  		@problems = Problem.all
  	
  		#tags
  		if params[:tags]
  			@problems = Problem.joins(:tags).merge(Tag.tag_name(params[:tags].split(",")))
  		end
	end

end
