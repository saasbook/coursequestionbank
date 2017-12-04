require 'spec_helper'

describe Instructor do
	pending "Need to be made backwards compatible with current code"
	skip

	describe 'create_with_omniauth' do
    before do
      auth = {"provider" => "github", "uid" => "12345",
              "info" => { "name" => "foo",
                          "nickname" => "nick",
                          "image" => "image",
                          "email" => "email@mail.com"
              }}
  		Instructor.create_via_omniauth(auth)
  		@instructor = Instructor.find_by_uid("12345")
	  end

	  after do
	    Instructor.find_by_uid("12345").destroy
	  end

	  xit 'should create a new instructor' do
	    expect(@instructor).to_not eq(nil)
	  end

	  xit 'should set the instructor provider' do
	    expect(@instructor.provider).to eq("github")
	  end

	  xit 'should set the instructor uid' do
	    expect(@instructor.uid).to eq("12345")
	  end

	  xit 'should set the instructor name' do
	    expect(@instructor.name).to eq("foo")
	  end

	  xit 'should set the instructor username' do
	    expect(@instructor.username).to eq("nick")
	  end

	  xit 'should set the instructor provider image' do
	    expect(@instructor.provider_image).to eq("image")
	  end

	  xit 'should set the instructor provider email' do
	    expect(@instructor.provider_email).to eq("email@mail.com")
	  end

    xit 'should set the instructor privilege to student by default' do
	    expect(@instructor.privilege).to eq("Student")
	  end
	end
end
