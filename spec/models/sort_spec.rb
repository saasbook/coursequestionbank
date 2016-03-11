require 'spec_helper'

describe 'sort' do
    before do
      @tf_problem = Problem.create(:problem_type => truefalse, :text => "truefalse text", :last_used => datetime.now)
      @later_fillin_problem = Problem.create(:problem_type => fill_in, :text => "fillin text", :last_used => datetime.now+datetime.timedelta(day=1))
    end
    
    it 'should only show true/false questions when the true/false checkbox is selected' do
      get :index, id: @problems, problem_type: { :truefalse => "1" }
      response.status.should be 302 
    end
    
    it 'should show most recently used problems first' do
      get :index, id: @problems, sort: 'last_used'
      response.status.should be 302 
    end
end
