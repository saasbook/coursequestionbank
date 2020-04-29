# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

require 'csv'

#have to clear all user data to fill correct data fields
Instructor.delete_all
Whitelist.delete_all

# These are only available when the omniauth 'developer' strategy is enabled (ie, not in production)

@uid = 1000
def create_seed_user(username, name, priv)
  @uid += 1
  u = Instructor.create!(
    :username => username, :name => name, :provider => 'developer', :uid => @uid)
  Whitelist.create!(
    :username => username, :provider => 'developer', :privilege => priv)
  u
end

admin =   create_seed_user('Administrator', 'Questionbank Admin', 'Admin')
student = create_seed_user('JoeS', 'Joe Student', 'Student')
gsi =     create_seed_user('GSI', 'Tara Teacher', 'Instructor')
instructor_id = gsi.id

# Seed problems from db/problems.csv, but make them all owned by the sole instructor, and access
# level of 2 (public)

Problem.delete_all
max_problems = 100
puts "Creating up to #{max_problems} problems..."
num_problems = 0
CSV.parse(File.read(File.join(Rails.root, 'db', 'problems.csv')), :headers => true).each do |p|
  Problem.create!(
    :access_level => 2,
    :text => p['text'],
    :rendered_text => p['rendered_text'],
    :problem_type => p['problem_type'],
    :json => p['json'],
    :bloom_category => p['bloom_category'],
    :uid => p['uid']
    ).update_attribute(:instructor_id, instructor_id)
  num_problems += 1
  break if num_problems == max_problems
end
puts "Created #{num_problems} problems"

# Create a few collections
per_collection = 50
(1..2).each do |i|
  puts "Creating collection #{i}"
  c = Collection.create!(:name => "Collection #{i}", :is_public => true, :description => 'A collection')
  c.update_attribute(:instructor_id, instructor_id)
  c.problems = Problem.all.offset((i-1)*per_collection).limit(per_collection)
  c.save!
end

