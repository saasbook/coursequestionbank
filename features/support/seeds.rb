# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@instructor = Instructor.create(name: "foo", provider: "github", uid: "12345")

@tag1 = Tag.create(name: "quiz 1")
@tag2 = Tag.create(name: "quiz 2")
@tag3 = Tag.create(name: "quiz 3")
@tag4 = Tag.create(name: "quiz 4")
@collection1 = Collection.create(name: "Fall 14")
@collection2 = Collection.create(name: "Spring 15")
@collection3 = Collection.create(name: "Spring 14")

@p1 = Problem.new(created_date: '2012-06-09 21:51:55 UTC', is_public: true, text:
               
               "choice_answer :randomize => true do
               text 'Which of the following best identifies the four basic operations supported by RDBMS?'
               distractor 'HTTP', :explanation => 'HTTP stands for HyperText Transfer Protocol, which is used to transfer SaaS content to browsers.'
               distractor 'Get, Put, Post, Delete', :explanation => 'These are four of the methods or verbs used by HTTP.'
               answer 'CRUD', :explanation => 'Create, Read, Update, Delete are the four basic database operations commonly performed by SaaS apps.'
               distractor 'REST', :explanation => 'REpresentational State Transfer is a design approach for making SaaS requests self-contained by having each request refer to a resource and an operation on that resource.'
               end"
               
               )
@p1.instructor = @instructor
@p1.tags << @tag1
@p1.tags << @tag4
@p1.collections << @collection1
@p1.collections << @collection2
@p1.save


@p2 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "select_multiple :randomize => true do
               text  'Which tiers in the three-tier architecture are involved in handling views?'
               answer 'Presentation'
               answer 'Logic'
               distractor 'Persistence'
               distractor 'Database'
               end" 
               
               )
@p2.instructor = @instructor
@p2.tags << @tag1
@p2.tags << @tag2
@p2.collections << @collection2
@p2.collections << @collection3
@p2.save


