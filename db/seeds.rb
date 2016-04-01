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
@user9 = Whitelist.create(username: "zhangaaron", privilege: "admin")

Problem.create(id: 1, text: "hello", json: "{\n  \"answers\": [\n    {\n      \"answer_text\": \"Rails itself isn't the problem, but the original Ruby VM does have some performance problems that impede scaling for heavy server workloads.\",\n      \"correct\": true,\n      \"explanation\": null\n    },\n    {\n      \"answer_text\": \"Rails itself isn't the problem, but the development processes typically used around Rails don't scale well to large teams.\",\n      \"correct\": true,\n      \"explanation\": null\n    },\n    {\n      \"answer_text\": \"If you're building a startup and expect high volume, Raffi Krikorian would advise you to stay away from Ruby and Rails from the start.\",\n      \"correct\": false,\n      \"explanation\": null\n    },\n    {\n      \"answer_text\": \"If Twitter had been architected as a service-oriented architecture from the start, they might have stayed on Ruby/Rails somewhat longer than they did.\",\n      \"correct\": true,\n      \"explanation\": null\n    }\n  ],\n  \"points\": 1,\n  \"raw\": null,\n  \"name\": null,\n  \"question_tags\": [\n\n  ],\n  \"question_comment\": \"\",\n  \"question_text\": \"Around 2007, the claim \\\"Rails doesn\\\\'t scale\\\"  was attributed to\\nTwitter engineers, and the fact that Twitter later moved\\naway from Rails was cited by some as evidence that the claim was true.\\nWhich of the following statements (there may be more than one) describe Raffi\\nKrikorian\\\\'s (Twitter Director of Engineering) views on this subject?\",\n  \"multiple\": true,\n  \"randomize\": false,\n  \"question_type\": \"SelectMultiple\"\n}")
