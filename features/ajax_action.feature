# PTID: 152415801
Feature: User should be able to know if AJAX action succeeds or not (making AJAX atomic)
  As a student, 
  I want to to be able to know if my request went through the system
  So that I do not have a confusing user experience

Background: 
  Given I am on the login page
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'bloom_test.txt'
  And I am on the CourseQuestionBank home page
  And I press "Remember"
  
Scenario: The AJAX action does not succeed
  Given I press "Understand"
  And the AJAX request does not succeed.
  Then I should see "The AJAX action did not succeed."
  And I check "Understand"
  And I press "Search"
  Then I should see "No questions matched your search criteria"
  