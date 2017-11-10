Feature: Student login
    As an student
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

# Scenario: Student should not see problem details
# 	Given I am on the problems page
#     Then I should not see "My Collections"  


