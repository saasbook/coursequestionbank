require 'spec_helper'

describe CollectionsController do
  
  describe 'add/remove multiple problems' do
    before do
      @instructor = Instructor.create(:privilege => "admin", :name => "bar", :uid => "11111")
			session[:user_id] = @instructor.id
			@collection = @instructor.collections.create(:name => 'col name').id
    end
    
    it 'should add or remove problems' do
      problem1 = Problem.create.id
      problem2 = Problem.create.id
      
      request.env["HTTP_REFERER"] = '/problems'
      
      post :add_problems, :id => @collection, :problem_ids => "#{problem1}, #{problem2}"
      expect(Collection.find(@collection).problems.size).to eq(2)
      
      post :remove_problems, :id => @collection, :problem_ids => "#{problem1}, #{problem2}"
      expect(Collection.find(@collection).problems.size).to eq(0)
    end
  end
end
