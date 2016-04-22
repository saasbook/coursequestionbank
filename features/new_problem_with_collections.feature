Feature: User can create a single new Problem and specify its Collections
  As an instructor
  So that I can organize my questions
  When I create a new problem
  I want to add a problem to a collection

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have created an empty collection named "History"

Scenario: Specifying a collection when creating question
  Given I am on the new problem page
  Then I should see "Add to Collection"
  When I fill in "ruql_source" with text of "history_test2.txt"
  And I press "Add to Collection"
  And I press "History"
  And I press "Create question"
  Then when I click "My Collections" I should see "History"
  And I should see "1" under "# Questions"
