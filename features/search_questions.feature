@search_questions
Feature: Search questions by question text
	As an instructor
	So that I can easily find questions
	And I have uploaded 'micro_quizzes.txt'
	I want to be able to search for questions by text

Background: 
	Given I am signed in with uid "1234" and provider "github"
	And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page

Scenario: searching by question text
	When I fill in "search" with "Rails doesn't scale"
	And I press "Apply"
	Then I should see "Twitter Director of Engineering"
	And I should not see "The basic types of activities involved in software"