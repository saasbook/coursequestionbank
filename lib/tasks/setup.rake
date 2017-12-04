namespace :setup do
  desc "Add an Admin by specifying GitHub username: rake setup:add_admin[github_username]"
  task :add_admin, [:username] => :environment do |task,args|
    username = args[:username]
    fail "Must specify GitHub username, as in 'rake setup:add_admin[github_username]'" if username.blank?
    Whitelist.create!(:username => username, :privilege => 'admin', :provider => 'github')
  end
  task :add_instructor, [:username] => :environment do |task,args|
    username = args[:username]
    fail "Must specify GitHub username, as in 'rake setup:add_admin[github_username]'" if username.blank?
    Whitelist.create!(:username => username, :privilege => 'instructor', :provider => 'github')
  end
end