require 'spec_helper'

describe Instructor do
  	it 'should store user from omniauth to db' do
  		auth = {"provider" => "github", "uid" => "12345", "info" => {"name" => "foo"}}
  		Instructor.create_with_omniauth(auth)
  		expect(Instructor.find_by_uid("12345").name).to eq("foo")
  		Instructor.find_by_uid("12345").destroy
	end
end
