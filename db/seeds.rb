# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#have to clear all user data to fill correct data fields
Instructor.delete_all

@user1 = Whitelist.create(username: "armandofox", privilege: "admin")
@user2 = Whitelist.create(username: "jshoe", privilege: "admin")
@user3 = Whitelist.create(username: "kellymtrinh", privilege: "admin")
@user4 = Whitelist.create(username: "kimeow", privilege: "admin")
@user5 = Whitelist.create(username: "brandonpickering", privilege: "admin")
@user6 = Whitelist.create(username: "jesmin-n", privilege: "admin")
@user7 = Whitelist.create(username: "scabanela", privilege: "admin")
@user8 = Whitelist.create(username: "jonsheu", privilege: "admin")