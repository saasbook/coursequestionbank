Feature: display list of questions filtered by tag

  As an instructor
  So that I can quickly find questions appropriate for my class
  I want to find questions matching only certain tags

Background: questions have been added to the database

Given the following questions exist:
    #some way to import ruql files

Background : the following users have been added and logged in

Given the following users exist
  | username  | password| 
  | fox             | fox |
  | dev   |        |dev|

And I am logged in as 'dev'


Scenario: restrict to questions with 'SaaS-Agile' tag
  When I search for the following tag: 'SaaS-Agile'
  Then I should see questions containing tags with 'SaaS-Agile’
  And I should not see questions containing tags with 'SaaS-Agile'

Scenario: enter no tags
  When I search for the following tags: ‘’
  Then I should see all questions

Scenario: sort by created date
  When I select ‘sort by created date’ in filters
  Then I should not see the question ‘foo’ before ‘bar’

Scenario: filter by created by
  When I select ‘sort by created by’ in filters
  Then I should see the question ‘foo’ before ‘bar’
  And I should not see the question ‘bar’ before ‘foo’ 


  



