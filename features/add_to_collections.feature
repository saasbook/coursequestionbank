Feature: User can add individual problems to a Collection
  As an instructor
  So that I can organize my collections of questions
  I want to add a problem to a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'bloom_test.txt'
  And I am on the CourseQuestionBank home page

Scenario: Add two collections that can see
  When I am on the CourseQuestionBank home page
  And I should see "Which of the following"
  And I press "show"

  When I checked "A few example questions"

  When I unchecked "A few example questions"


