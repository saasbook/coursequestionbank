Feature: User can remove individual problems from a Collection
  As an instructor
  So that I can organize my collections of questions
  I want to remove a problem from a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt'

Scenario: Removing a problem from a collection
  Given I am on the dashboard
  And I follow "1/22/15 (W1 L2)"
  And I press button "remove" for problem containing "Around 2007"
  Then I should see "Removed problem from collection"
  Given I am on the dashboard
  And I follow "1/22/15 (W1 L2)"
  Then I should not see "Around 2007"
