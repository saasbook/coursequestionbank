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
	Given I successfully upload a file
	Then I should be on the success page

Scenario: attempted upload without a file selected
	Given I am on the upload page
	And I press upload without selecting a file
	Then I should see a flash message asking me to select a file

Scenario: upload a file unsuccessfully
	Given I am on the upload page
	And I have selected a file to upload
	And I press the upload button
	And the upload fails
	Then I should see a flash message telling me of failure
