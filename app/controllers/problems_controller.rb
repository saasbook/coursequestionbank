class ProblemsController < ApplicationController

    def home
        redirect_to problems_path
    end

	def index
  		@problems = @current_user.problems
  	  @collections = Set.new
      @problems.each { |p| @collections.merge(p.collections)  }
  		
      filter_options = params.slice(:tags, :collections, :last_exported)
      #tags
  		if params[:tags]
  			@problems = Problem.joins(:tags).merge(Tag.tag_name(params[:tags].split(",")))
  		end
	end

end
