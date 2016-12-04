Feature: Students answer questions
  As a student,
  So I can learn and practice,
  I want to be able to answer the questions


Background:
  Given I am signed in with uid "1234" and provider "github"
  Then I should see "Admin"
  And I have uploaded 'test_fill_in.txt'
  And I am on the CourseQuestionBank home page

Scenario: I can answer a fill-in-the-blank question
  Given I am signed in with uid "12345" and provider "github"
  And I am on the CourseQuestionBank home page
  And I fill in "eb3f6f5e-99b4-4d3e-b961-6deb47c23591" with "/route/i"
  And I press "Check Answer"
#  And I should see a correct message
#  And I fill in "fill-in" with "Java"
#  And I press "Check Answer"
#  And the plain text "Wrong" is shown
