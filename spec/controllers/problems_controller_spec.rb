require 'spec_helper'

describe ProblemsController do
	before :each do
		
	end
	describe 'filter' do
		it 'should call model\'s filter method' do
			Problem.should_receive(:filter)
			controller.index
		end

	end


end