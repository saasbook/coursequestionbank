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
  
Scenario: I am online. 
  Given I press "Understand"
  And I check "Understand"
  Then I press "Search"
  Then the question should be part of "Understand"
  And I uncheck "Understand"
  And I check "Remember"
  Then I press "Search"
  And the question should not be part of "Remember"

Scenario: I am offline. 
  Given I am offline 
  And I press "Understand"
  Then the "Understand" button should not be blue 
  And the "Remember" button should be blue