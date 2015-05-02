require 'spec_helper'

describe Ability do
  it "should allow admins to delete problems" do
    user = Instructor.create(name: 'yolo', privilege: "admin")
    ability = Ability.new(user)
    assert ability.can?(:destroy, Problem)
  end
  it "shouldn't permit stupid people to do stupid things" do 
    user = Instructor.create(name: 'yoloswagjesus', privilege: 'instructor')
    ability = Ability.new(user)
    assert ability.cannot?(:create, Instructor)
  end 
end
