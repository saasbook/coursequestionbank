Feature: User can upload Ruql source code with a universal ID to identify questions
  As an instructor
  So that I can keep track of individual questions across systems
  I want to give each question a unique ID

Background:
  Given I am signed in with uid "1234" and provider "github"
  Given I have uploaded 'new_universal_id.txt'

Scenario: Uploading a question with a new universal ID
  And I am on the home page
  And I follow "View 60"
  Then the problem containing "Rails doesn't scale" should have a non-empty uuid

Scenario: Superseded questions have new universal IDs
  And I am on the CourseQuestionBank home page
  When I follow "supersede_button" for problem containing "Rails doesn't scale"
  And I fill in "ruql_source" with text of "new_universal_id2.txt"
  And I press "Supersede question"
  And I am on the CourseQuestionBank home page
  Then the problem containing "Rails doesn't scale" should not have the uuid of the original problem
  And I should not see "This part should disappear"
