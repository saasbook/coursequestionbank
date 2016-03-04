@omniauth_test
Feature: Login with github
	As an instructor
	So that I can access the application
	I want to login to the app with github

Background:
	Given I am signed in with uid "1234" and provider "github"
	And I am on the CourseQuestionBank home page

Scenario: redirect to login page if not logged in
	Given I am not logged in
	And I am on the CourseQuestionBank home page
	Then I should be on the login page

Scenario: redirect to home page if login successful
	Given I am on the login page
	And I follow "Log in with your GitHub account"
	Then I should be on the problems page

Scenario: redirect to login page if login unsuccessful
	Given I am on the login page
	And I follow "Log in with your GitHub account"
	And login was unsuccessful
	Then I should be on the login page
	And I should see "Authentication failed, please try again."
