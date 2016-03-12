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
			problem = Problem.create.id
			
			request.env["HTTP_REFERER"] = '/problems'
			post :add_tags, :id => problem, :add_tag_names => "tag1, tag2"
			
			expect(Problem.find(problem).tags.size).to eq(2)
		end
	end
end