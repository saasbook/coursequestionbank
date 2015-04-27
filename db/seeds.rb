# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user1 = Whitelist.create(username: "armandofox", privilege: "admin")
@user2 = Whitelist.create(username: "ishustava", privilege: "admin")
@user3 = Whitelist.create(username: "zhangaaron", privilege: "admin")
@user4 = Whitelist.create(username: "ingridh", privilege: "admin")
@user5 = Whitelist.create(username: "dradding", privilege: "admin")
@user6 = Whitelist.create(username: "rahdor", privilege: "admin")
@user7 = Whitelist.create(username: "siddhantpuri", privilege: "admin")







