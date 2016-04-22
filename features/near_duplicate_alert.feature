Feature: User is alerted when uploading a Problem with text similar to an existing Problem
  As an instructor
  So that I can avoid near-duplicated problems
  I want to know when I upload near-duplicates

Background:
  Given I am signed in with uid "1234" and provider "github"
  And I am on the upload page

Scenario: User tries to upload different question (sad path, no duplicate detected)
  Given I am on the upload page
  And I attach the file "features/test_files/foo.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Upload successful!"

Scenario: User tries to upload exact copy of question
  When I attach the file "features/test_files/foo.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Upload successful!"
  Given I am on the upload page
  When I attach the file "features/test_files/foo_dup.txt" to "file_upload"
  Then I should see "Warning: possible duplicate found. Please resolve."
  And I should be on the duplicate page

Scenario: User tries to upload near duplicate
  When I attach the file "features/test_files/foo.txt" to "file_upload"
  And I press "Upload File"
  Then I should see "Upload successful!"
  Given I am on the upload page
  When I attach the file "features/test_files/foo_near_dup.txt" to "file_upload"
  Then I should see "Warning: possible duplicate found. Please resolve."
  And I should be on the duplicate page
