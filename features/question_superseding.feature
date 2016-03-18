Feature: User can supersede a Question with new question source code
  As an instructor,
  So that I can replace a Question with a superseded version,
  I want to update a Question with new source code

Scenario: replacing a question with a new version
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'history_test.txt'
  And I am on the CourseQuestionBank home page
  When I press "Supersede"
  And fill in 'update' with 'history_test2.txt'
  And I press "Save"
  Then I should see 'Question has been updated'
  And I should see the text from 'history_test2.txt'
