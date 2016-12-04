Feature: User can add problem to collection that using checkbox
  As an instructor
  So that I can organize my collections of questions
  I want to remove a problem from a collection

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'bloom_test.txt'
    And I am on the CourseQuestionBank home page

  Scenario: Check a checkbox that show plain text
    And I press "show"
    And I check "A few example questions" checkbox
    Then the "A few example questions" checkbox should be checked
    Then I should see "A few example questions"
#    And the plain text "A few example questions" is shown
    