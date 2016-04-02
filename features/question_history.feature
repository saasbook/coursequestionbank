Feature: User can see past, superseded versions of a Question's content
  As an instructor,
  So that I can keep track of how a question has changed,
  I want to view past versions of a Question

Scenario: seeing past versions of a question
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'history_test.txt'
  And I am on the CourseQuestionBank home page
  
  When I follow "supersede_button" for problem containing "This was the original version"
  And I fill in "ruql_source" with text of "history_test2.txt"
  And I press "Supersede question"
  Then I should be on the problems page
  
  When I follow "supersede_button" for problem containing "This is the previous version"
  And I fill in "ruql_source" with text of "history_test3.txt"
  And I press "Supersede question"
  Then I should be on the problems page
  
  And I should see "This is the most recent version"
  And I should see "This is the previous version"
  And I should see "This was the original version"