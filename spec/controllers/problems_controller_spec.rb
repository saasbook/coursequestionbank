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
			@instructor = Instructor.create(:username => "bar", :provider => 'github')
      Whitelist.create(:username => @instructor.username, :provider => @instructor.provider, :privilege => 'admin')
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
			@instructor = Instructor.create(:username => "bar", :provider => 'github')
      Whitelist.create(:username => @instructor.username, :provider => @instructor.provider, :privilege => 'admin')
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

	describe 'update_multiple_tags' do
    before do
      @instructor = Instructor.create(:username => "bar", :provider => 'github')
      Whitelist.create(:username => @instructor.username, :provider => @instructor.provider, :privilege => 'admin')
			session[:user_id] = @instructor.id
    end

    it 'should add tags' do
      problem1 = Problem.create(:is_public => true, :uid => "124u2i").id
      problem2 = Problem.create(:is_public => true, :uid => "bgn2j1").id
      checked_hash = {problem1.to_s => "1", problem2.to_s => "1"}

      request.env["HTTP_REFERER"] = '/problems'
      post :update_multiple_tags, :tag_names => "tag1, tag2", :checked_problems => checked_hash

      expect(Problem.find(problem1).tags.size).to eq(2)
      expect(Problem.find(problem2).tags.size).to eq(2)
    end
  end

  describe 'update' do
  	before do
      @instructor = Instructor.create(:username => "bar", :provider => 'github')
      Whitelist.create(:username => @instructor.username, :provider => @instructor.provider, :privilege => 'admin')
			session[:user_id] = @instructor.id
			request.env["HTTP_REFERER"] = '/problems'
			@problem = @instructor.problems.create.id
    end

    it 'should set privacy to public' do
    	post :update, :id => @problem, :privacy => 'public'
    	expect(Problem.find(@problem).is_public).to eq(nil)
    end

    it 'should set privacy to private' do
    	post :update, :id => @problem, :privacy => 'private'
    	expect(Problem.find(@problem).is_public).to eq(nil)
    end

    it 'should set obsolete' do
    	post :update, :id => @problem, :obsolete => '1'
    	expect(Problem.find(@problem).obsolete).to eq(true)
    end

    it 'should set bloom category' do
    	post :update, :id => @problem, :category => 'Understand'
    	expect(Problem.find(@problem).bloom_category).to eq('Understand')
    end

    it 'should unset bloom category' do
    	post :update, :id => @problem, :category => 'none'
    	expect(Problem.find(@problem).bloom_category).to eq(nil)
    end
  end
end
