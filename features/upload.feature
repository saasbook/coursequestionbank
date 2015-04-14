Feature: Upload a RUql file
	As an instructor
	So that I can add questions
	I want to upload a RUql file

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
	And I press "upload"
	Then I should see "Sucessfully uploaded file"

Scenario: syntax error in the file
	Given I am on the upload page
	And I attach the file "features/test_files/foo_error.txt" to "file_upload"
	And I press "upload"
	Then I should see "There is an error in the file"


