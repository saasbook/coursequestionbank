Feature: Student should be able to search for questions 
  As a student, 
  I want to to be able to search questions by typing in keywords
  So that I narrow down the questions to study from 

Background: 
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'foo.txt'
  Then I am signed in with uid "12345" and provider "developer"
  
  And I am on the login page
  And I follow "Log in with your GitHub account"
  Then I should be on the problems page
  And I should see "Student!"

Scenario: searching by question text
    # PTID 152770443
    When I fill in "Search Keywords" with "HyperText Transfer Protocol"
    And I press "Search"
    Then I should not see "You don't have permission to access this page."
    And I should see "RDBMS"
    And I should not see "implied port number"
