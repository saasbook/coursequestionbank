Feature: User can create a single new Problem and specify a Bloom rating
  As an instructor
  So that I can organize my questions
  When I create a new problem
  I want to give it a Bloom rating

Background:
  Given I am signed in with uid "1234" and provider "github"

Scenario: Specifying a bloom rating when creating question
  Given I am on the new problem page
  When I fill in "ruql_source" with text of "history_test2.txt"
  And I select "Understand" from "category"
  And I press "Create question"
  Given I am on the problems page
  And I check "Understand"
  And I press "Search"
  Then I should not see "No questions matched your search criteria"
