Feature: User will see a 'dup' tag to resolve near-duplicate Problems
  As an instructor
  So that I can avoid near-duplicates
  I want to be able to see specific near-duplicate problems

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'micro_quizzes.txt'
  And I am on the upload page

Scenario: User tries to upload near duplicate
  When I attach the file "micro_quizzes_dup.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Warning: possible duplicate found. Please resolve."
  And I should be on the duplicate page
  Then problem containing "Around 2007, the claim" should have the tag "dup"

Scenario: User tries to upload different question (sad path, no duplicate detected)
  Given I am on the upload page
  And I attach the file "features/test_files/foo.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Upload successful!"
  And problem containing "Around 2007, the claim" should not have the tag "dup"
