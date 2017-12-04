Feature: Upload a RuQL file
	As an instructor
	So that I can add questions
	I want to upload a RuQL file

Background:
	Given I am signed in with uid "1234" and provider "github"
	And I am on the upload page

Scenario: redirect to login page if not logged in
	Given I am not logged in
	And I am on the upload page
	Then I should be on the login page

Scenario: upload a file successfully
	Given I am on the upload page
	And I attach the file "features/test_files/foo.txt" to "file_upload"
	And I press "Upload File"
	Then I should see "Upload successful!"

Scenario: upload a file successfully
    Given I am on the upload page
    And I attach the file "features/test_files/advanced_render.txt" to "file_upload"
    And I press "Upload File"
    Then I should see "Upload successful!"

Scenario: syntax error in the file
	Given I am on the upload page
	And I attach the file "features/test_files/foo_error.txt" to "file_upload"
	And I press "Upload File"
	Then I should see "undefined method"

Scenario: upload same file twice
	Given I am on the upload page
	And I attach the file "features/test_files/foo.txt" to "file_upload"
	And I press "Upload File"
	Given I am on the upload page
	And I attach the file "features/test_files/foo.txt" to "file_upload"
	And I press "Upload File"
	Then I should see "Quiz with that name already exists in your list of collections. You probably didn't mean to upload the same quiz again. Try deleting the old collection and upload again if you really meant to do that"