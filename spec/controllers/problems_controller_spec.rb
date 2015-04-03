require 'spec_helper'

describe ProblemsController do
	before :each do
		
	end
	describe 'filter' do
		it 'should call model\'s filter method' do
			Collection.stub(:collections_for_user).and_return([])
			Problem.should_receive(:filter)
			controller.index
		end

		it 'should call collections method for the current user' do
			Problem.stub(:filter).and_return([])
			Collection.should_receive(:collections_for_user)
			controller.index
		end
	end


end