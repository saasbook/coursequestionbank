require 'spec_helper'

describe ProblemsController do
	# before :each do
	# 	session[:user_id] = Instructor.find_by_uid("1234")
	# end
	# describe 'filter' do
	# 	it 'should call model\'s filter method' do
	# 		Problem.should_receive(:filter)
	# 		controller.index
	# 	end
	# end
	
	describe 'add_tags' do
		before do
			@instructor = Instructor.create(:privilege => "admin", :name => "bar", :uid => "11111")
			session[:user_id] = @instructor.id
		end
		
		it 'should add tags' do
			problem = Problem.create(:is_public => true).id
			
			request.env["HTTP_REFERER"] = '/problems'
			post :add_tags, :id => problem, :tag_names => "tag1, tag2"
			
			expect(Problem.find(problem).tags.size).to eq(2)
		end
	end
	
	describe 'remove_tags' do
		before do
			@instructor = Instructor.create(:privilege => "admin", :name => "bar", :uid => "11111")
			session[:user_id] = @instructor.id
		end
		
		it 'should remove tags' do
			problem = Problem.create(:is_public => true)
			problem.add_tags(['tag 1', 'tag 2', 'tag 3'])
			
			request.env["HTTP_REFERER"] = '/problems'
			post :remove_tags, :id => problem.id, :tag_names => 'tag 1, tag 2'
			
			expect(Problem.find(problem.id).tags.size).to eq(1)
		end
	end
	
	describe 'set_privacy' do
		before do
			@instructor = Instructor.create(:privilege => "admin", :name => "bar", :uid => "11111")
			session[:user_id] = @instructor.id
		end
		
		it 'should set privacy' do
			problem = @instructor.problems.create(:is_public => false)
			
			request.env["HTTP_REFERER"] = '/problems'
			post :set_privacy, :id => problem.id, :privacy => 'public'
			
			expect(Problem.find(problem.id).is_public).to eq(true)
		end
	end
	
	describe 'update_multiple_tags' do
    before do
      @instructor = Instructor.create(:privilege => "admin", :name => "bar", :uid => "11111")
			session[:user_id] = @instructor.id
    end
    
    it 'should add tags' do
      problem1 = Problem.create(:is_public => true).id
      problem2 = Problem.create(:is_public => true).id
      checked_hash = {problem1.to_s => "1", problem2.to_s => "1"}
      
      request.env["HTTP_REFERER"] = '/problems'
      post :update_multiple_tags, :tag_names => "tag1, tag2", :checked_problems => checked_hash
      
      expect(Problem.find(problem1).tags.size).to eq(2)
      expect(Problem.find(problem2).tags.size).to eq(2)
    end
  end
end