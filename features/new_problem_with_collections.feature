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
  When I fill in "ruql_source" with text of "history_test2.txt"
  And I check "History"
  And I press "Create question"
  When I am on the profile page
  And I follow "History"
  And I should see "This is the previous version"
