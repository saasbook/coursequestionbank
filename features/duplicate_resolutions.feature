Feature: User can mark a near-duplicate Problem as obsolete
  As an instructor
  In order to resolve duplicates
  I want to mark a duplicate problem as obsolete

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt'
  And I am on the upload page

Scenario: User can resolve duplicates by marking one as obsolete
  When I attach the file "micro_quizzes_dup.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Warning: possible duplicate found. Please resolve."
  And I should be on the duplicate page
  Then problem containing "Around 2007, the claim" should have the tag "dup"
  When I mark problem with uid "123" as obsolete
  Then the problem containing "Around 2007, the claim" should not have the tag "dup"
