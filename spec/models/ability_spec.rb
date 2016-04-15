require 'spec_helper'

describe Ability do
  it "shouldn't permit stupid people to do stupid things" do    # I wouldn't call professors stupid
    user = Instructor.create(:username => "bar", :provider => 'github')
    Whitelist.create(:username => user.username, :provider => user.provider, :privilege => 'instructor')
    ability = Ability.new(user)
    assert ability.cannot?(:create, Instructor)
  end 
end
