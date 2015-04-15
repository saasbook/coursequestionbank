# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@instructor = Instructor.create(name: "foo", provider: "github", uid: "1234")

@tag1 = Tag.create(name: "quiz 1")
@tag2 = Tag.create(name: "quiz 2")
@tag3 = Tag.create(name: "quiz 3")
@tag4 = Tag.create(name: "quiz 4")
@collection1 = @instructor.collections.create(name: "Fall 14")
@collection2 = @instructor.collections.create(name: "Spring 15")
@collection3 = @instructor.collections.create(name: "Spring 14")





