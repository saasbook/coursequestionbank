Feature: User can mark a near-duplicate Problem as obsolete
  As an instructor
  In order to resolve duplicates
  I want to mark a duplicate problem as obsolete

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'dup_test_first.txt'
  And I am on the upload page

Scenario: User can resolve duplicates by marking one as obsolete
  When I attach the file "features/test_files/dup_test_second.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Near-duplicate questions may have been uploaded!"
  Then the problem containing "The quick brown fox jumped over the lazy dog" should have the tag "dup"
  And I should be on the finalize upload page
