class ProblemsController < ApplicationController

    def home
        redirect_to problems_path
    end

    def index
        @problems = Problem.all
    end
end
