Feature: User can view and export a Question's Ruql source code with a universal ID
  As an instructor
  So that I can keep track of individual questions across systems
  I want to view a universal ID in a Question's Ruql source code

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'universal_id_test.txt'
  And I am on the CourseQuestionBank home page
  And I follow "View 60"

Scenario: Viewing source code for a question with a universal ID
  When I follow "supersede_button" for problem containing "This problem should have unique bananas and potatoes."
  Then I should see "b804b480029121a507a47cc5135cae72e4f18289618f38254665d3e6a3bbd4a7"
