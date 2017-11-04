Feature: User can search for a collection
  As an instructor/admin
  So that I can locate an collection quickly
  I want to be able to search a collection by name or owner name

Background:
  Given I am signed in with uid "1234" and provider "github"

  
Scenario: I search a collection with empty string
  When I am on the dashboard
  When I fill in "Search" with ""
  And I press "Search"
  Then I should not see "cs169"
  Then I should not see "A few example questions"
  Then I should see "You have no collections."

Scenario: I search a collection that does not exist
  And I have uploaded 'bloom_test.txt'
  When I am on the dashboard
  When I fill in "Search" with "cs169"
  And I press "Search"
  Then I should not see "cs169"
  Then I should not see "A few example questions"
  Then I should see "No collection matches"


Scenario: I search by collection name that User uploaded
  When I have uploaded 'bloom_test.txt'
  When I am on the dashboard
  When I fill in "Search" with "A few example questions"
  And I press "Search"
  Then I should see "A few example questions"
  Then I should not see "cs169"
  Then I should not see "No collection matches"


Scenario: I search by collection with empty string
  And I have uploaded 'bloom_test.txt'
  When I am on the dashboard
  When I fill in "Search" with ""
  Then I should see "A few example questions"
  Then I should not see "cs169"
  Then I should not see "No collection matches"
