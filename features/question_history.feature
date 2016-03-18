Feature: User can see past, superseded versions of a Question's content
  As an instructor,
  So that I can keep track of how a question has changed,
  I want to view past versions of a Question

Scenario: seeing past versions of a question
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'history_test.txt'
  And I am on the CourseQuestionBank home page
  Then I should see "This is the most recent version"
  And I should see "This is the previous version"
  And I should see "This was the original version"
