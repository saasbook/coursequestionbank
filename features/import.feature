Feature: import ruql questions from my local hard drive onto the server and correctly displayed in database.
  As an instructor
  So that I can share my tests with other instructors and TAs
  I want to be able to upload my local ruql files to the database

  Scenario: import questions
    When I follow 'import questions'
    Then I should be on the import page
    
  Scenario: import invalid question
    When I follow 'import questions'
    And I upload 'invalid.rb'
    Then I should be on the import page.
    And I should see a warning 'Ruql format not recognized'


  Scenario: add tag to question
    Given I create a question 'foo'
    And I follow 'create tag'
    And I enter 'SaaS-Agile'
    Then I should see 'Saas-Agile' as a tag