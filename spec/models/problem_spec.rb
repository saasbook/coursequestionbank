require 'spec_helper'

describe Problem do
  	it 'should store problem associated with instructor' do
  		@instructor = Instructor.create(:privilege => "admin", :name => "bar", :uid => "11111")
  		@problem = @instructor.problems.create(:text => "foo")
  		expect(Problem.find_by_text("foo").instructor_id).to eq(Instructor.find_by_uid("11111").id)
	end
end
