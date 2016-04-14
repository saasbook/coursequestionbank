# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#have to clear all user data to fill correct data fields
Instructor.delete_all

@user1 = Whitelist.create(username: "armandofox", provider: "github", privilege: "admin")
@user2 = Whitelist.create(username: "jshoe", provider: "github", privilege: "admin")
@user3 = Whitelist.create(username: "kellymtrinh", provider: "github", privilege: "admin")
@user4 = Whitelist.create(username: "kimeow", provider: "github", privilege: "admin")
@user5 = Whitelist.create(username: "brandonpickering", provider: "github", privilege: "admin")
@user6 = Whitelist.create(username: "jesmin-n", provider: "github", privilege: "admin")
@user7 = Whitelist.create(username: "scabanela", provider: "github", privilege: "admin")
@user8 = Whitelist.create(username: "jonsheu", provider: "github", privilege: "admin")
@user9 = Whitelist.create(username: "zhangaaron", provider: "github", privilege: "admin")
