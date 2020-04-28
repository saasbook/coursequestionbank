# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

require 'csv'

#have to clear all user data to fill correct data fields
Instructor.delete_all
Whitelist.delete_all

# These are only available when the omniauth 'developer' strategy is enabled (ie, not in production)

Instructor.create!(username: "Admin", uid: "adm", name: "Questionbank Admin", provider: "developer")
Whitelist.create!(username: "Admin", provider: "dev", privilege: "Admin")

instructor =
  Instructor.create!(username: "JoeS", uid: "stu", name: "Joe Student", provider: "developer")
Whitelist.create!(username: "Joe Student", provider: "developer", privilege: "Student")

Instructor.create!(username: "GSI", uid: "gsi", name: "Tony Lee", provider: "developer")
Whitelist.create!(username: "GSI", provider: "developer", privilege: "Instructor")

# Seed problems from db/problems.csv, but make them all owned by the sole instructor, and access
# level of 2 (public)

Problem.delete_all
max_problems = 10
CSV.parse(File.read(File.join(Rails.root, 'db', 'problems.csv')), :headers => true).each do |p|
  Problem.create!(
    :access_level => 2,
    :text => p['text'],
    :rendered_text => p['rendered_text'],
    :problem_type => p['problem_type'],
    :json => p['json'],
    :bloom_category => p['bloom_category'],
    :uid => p['uid']
    ).update_attribute(:instructor_id, instructor.id)
  max_problems -= 1
  break if max_problems.zero?
end
