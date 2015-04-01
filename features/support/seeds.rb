#setup file. should be the same in both features/support/ and db/
    Problem.create(created_date: '2012-06-09 21:51:55 UTC', is_public: true, text:

    "choice_answer :randomize => true do
        text 'Which of the following best identifies the four basic operations supported by RDBMS?'
        distractor 'HTTP', :explanation => 'HTTP stands for HyperText Transfer Protocol, which is used to transfer SaaS content to browsers.'
        distractor 'Get, Put, Post, Delete', :explanation => 'These are four of the methods or verbs used by HTTP.'
        answer 'CRUD', :explanation => 'Create, Read, Update, Delete are the four basic database operations commonly performed by SaaS apps.'
        distractor 'REST', :explanation => 'REpresentational State Transfer is a design approach for making SaaS requests self-contained by having each request refer to a resource and an operation on that resource.'
    end" 

  ).tags.create(name: 'cucumber')

    rails = Tag.create(name: 'rails')
    Problem.create(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:

    "select_multiple :randomize => true do
        text  'Which tiers in the three-tier architecture are involved in handling views?'
        answer 'Presentation'
        answer 'Logic'
        distractor 'Persistence'
        distractor 'Database'
    end" 

  ).tags.push(rails)

    Problem.create(created_date: '2014-06-09 21:11:55 UTC', is_public: true,  text:
        "choice_answer :randomize => true do
            text 'The ----- tier of three-tier SaaS apps is the most complicated to scale.'
            answer 'Presentation'
            distractor 'Logic'
            distractor 'Persistence'
            distractor 'Database'
        end"
    ).tags.push(rails)

    puts 'seeds successfully imported --------'

