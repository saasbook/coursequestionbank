Feature: User is alerted when uploading a Problem with text similar to an existing Problem
  As an instructor
  So that I can avoid near-duplicated problems
  I want to know when I upload near-duplicates

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I have uploaded 'dup_test_first.txt'
  And I am on the upload page

Scenario: User tries to upload different question (sad path, no duplicate detected)
  Given I am on the upload page
  And I attach the file "features/test_files/foo.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Upload successful!"

Scenario: User tries to upload exact copy of question
  When I attach the file "features/test_files/dup_test_second.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Near-duplicate questions may have been uploaded"
  Then the problem containing "The quick brown fox jumped over the lazy dog" should have the tag "dup"
  And I should be on the finalize upload page

Scenario: User tries to upload near duplicate
  When I attach the file "features/test_files/dup_test_third.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Near-duplicate questions may have been uploaded"
  Then the problem containing "The quick brown fox jumped over the lazy dog" should have the tag "dup"
  And the problem containing "The quick brown fox jumped over the lazy cat" should have the tag "dup"
  And I should be on the finalize upload page
