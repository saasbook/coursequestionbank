require 'spec_helper'

describe Problem do
  	it 'should store problem associated with instructor' do
  		@instructor = Instructor.create(:username => "bar", :provider => 'github')
      Whitelist.create(:username => @instructor.username, :provider => @instructor.provider, :privilege => 'admin')
  		@problem = @instructor.problems.create(:text => "foo")
  		expect(Problem.find_by_text("foo").instructor_id).to eq(@instructor.id)
	end
	
	describe 'add_tag' do
	  before(:each) do
	    @problem = Problem.create
	  end
	  
	  it 'should create new tags' do
	    expect(Tag).to receive(:create).with(:name => "tag3").and_return(Tag.new(:name => "tag3"))
	    @problem.add_tag("tag3")
	  end
	  
	  it 'should not add tags if they already are added' do
	    @problem.tags.create(:name => "tag2")
	    old_size = @problem.tags.size
	    @problem.add_tag("tag2")
	    expect(@problem.tags.size).to eq(old_size)
	  end
	  
	  it 'should add tags' do
      old_size = @problem.tags.size
	    @problem.add_tag("tag1")
	    expect(@problem.tags.size).to eq(old_size + 1)
	  end
	end
	
	describe 'add_tags' do
	  it 'should add multiple tags' do
	    problem = Problem.create
	    problem.add_tags(['tag1', 'tag2', 'tag3'])
	    expect(problem.tags.size).to eq(3)
	  end
	end
end
