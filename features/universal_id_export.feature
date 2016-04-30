Feature: User can view and export a Question's Ruql source code with a universal ID
  As an instructor
  So that I can keep track of individual questions across systems
  I want to view a universal ID in a Question's Ruql source code

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'new_universal_id.txt'
  And I am on the CourseQuestionBank home page
  And I follow "View 60"

Scenario: Viewing source code for a question with a universal ID
  Then I should see "UUID"
  And I should see "Around 2007, the claim"
  And I should not see "This part should disappear"