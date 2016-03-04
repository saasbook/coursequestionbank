@search_questions
Feature: Search questions by question text
	As an instructor
	So that I can easily find questions
	And I have uploaded 'micro_quizzes.txt'
	I want to be able to search for questions by text

	As an instructor,
	So that I can find past questions when making an exam,
	I want to search questions by keywords and full text

	Background:
		Given I am signed in with uid "1234" and provider "github"
		And I have uploaded 'micro_quizzes.txt'
	    And I am on the CourseQuestionBank home page

	Scenario: searching by question text
		When I fill in "search" with "Rails doesn't scale"
		And I press "Apply"
		Then I should see "Twitter Director of Engineering"
		And I should not see "The basic types of activities involved in software"

	Scenario: search by tag

	Scenario: search by keyword

	Scenario: search by something that is both a tag and keyword in text

	Scenario: search by something that is not a tag or keyword (sad path)
