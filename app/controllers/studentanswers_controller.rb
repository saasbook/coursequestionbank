class StudentanswersController < ApplicationController
  # :attempt, :correctness, :problem_uid, :last_used, :updated_at, :created_date
  def create

    # new answer

    # debugger
    if (params[:attempt] != "" && @current_user.get_privilege == "Student")

      answer = Studentanswer.new()
      answer.attempt =  params[:attempt]
      answer.correctness = params[:correctness]
      answer.problem_uid = params[:problem_uid]
      answer.instructor_id =  @current_user.id
      answer.created_at = DateTime.current
      # debugger
      answer.problem_id = Problem.find_by_uid(params[:problem_uid]).id

      problem = Studentanswer.where(:problem_uid => params[:problem_uid]).where(:instructor_id =>  @current_user.id)

      # debugger
      if(problem == [])
        answer.first = true
      else
        answer.first = false
      end

      answer.save
    end


    if request.xhr?
      render :json => {'error' => nil}
    else
      redirect_to :back
    end
  end
end
