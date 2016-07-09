# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

#have to clear all user data to fill correct data fields
Instructor.delete_all

# These two are only available when the omniauth 'developer' strategy is enabled (ie, not in production)
@user00 = Instructor.create!(username: "saas", uid: "saas", name: "SaaS Instructor", provider: "developer")
Whitelist.create!(username: @user00.username, provider: "developer", privilege: "instructor")
@user01 = Instructor.create!(username: "saas-admin", uid: "saas-admin", name: "Admin", provider: "developer")
Whitelist.create!(username: @user01.username, provider: "developer", privilege: "admin")


