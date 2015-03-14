# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    Problem.create(created_by:'hello', created_date: '2012-06-09 21:51:55 UTC', is_public: true, text:

    "choice_answer :randomize => true do
        text 'Which of the following best identifies the four basic operations supported by RDBMS?'
        distractor 'HTTP', :explanation => 'HTTP stands for HyperText Transfer Protocol, which is used to transfer SaaS content to browsers.'
        distractor 'Get, Put, Post, Delete', :explanation => 'These are four of the methods or verbs used by HTTP.'
        answer 'CRUD', :explanation => 'Create, Read, Update, Delete are the four basic database operations commonly performed by SaaS apps.'
        distractor 'REST', :explanation => 'REpresentational State Transfer is a design approach for making SaaS requests self-contained by having each request refer to a resource and an operation on that resource.'
    end" 

  )


    Problem.create(created_by:'world', created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:

    "select_multiple :randomize => true do
        text  'Which tiers in the three-tier architecture are involved in handling views?'
        answer 'Presentation'
        answer 'Logic'
        distractor 'Persistence'
        distractor 'Database'
    end" 

  )

    Problem.create(created_by: "fox",created_date: '2014-06-09 21:11:55 UTC', is_public: true, text:
        "choice_answer :randomize => true do
            text 'The ----- tier of three-tier SaaS apps is the most complicated to scale.'
            answer 'Presentation'
            distractor 'Logic'
            distractor 'Persistence'
            distractor 'Database'
        end"
    )