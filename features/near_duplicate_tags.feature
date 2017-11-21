#PTID: 152624808
Feature: User will see a 'dup' tag to resolve near-duplicate Problems
  As an instructor
  So that I can avoid near-duplicates
  I want to be able to see specific near-duplicate problems

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'dup_test_first.txt'
  And I am on the upload page

Scenario: User tries to upload near duplicate
  When I attach the file "features/test_files/dup_test_third.txt" to "file_upload"
  And I press "Upload File"
  Then I should not see "Near-duplicate questions may have been uploaded" #PTID 152624808 requested that this implementation be removed
  Then the problem containing "The quick brown fox jumped over the lazy dog" should have the tag "dup"
  And the problem containing "The quick brown fox jumped over the lazy cat" should have the tag "dup"
  And I should be on the finalize upload page

Scenario: User tries to upload different question (sad path, no duplicate detected)
  Given I am on the upload page
  And I attach the file "features/test_files/foo.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Upload successful!"
  And I have yet to implement near-duplicate #PTID 152624808  requested that this implementation be removed
  And the problem containing "Which of the following best identifies" should not have the tag "dup"
