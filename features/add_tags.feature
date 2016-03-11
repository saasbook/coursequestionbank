Feature: add a tag to existing question
  As an CourseQuestionBank Administrator
  So that I can quickly find questions appropriate for my class
  I want to add tags to questions

  As an CourseQuestionBank Administrator
  So that I will be able to search for related questions,
  I want to tag my questions

  As an CourseQuestionBank Administrator
  So that I can categorize my questions,
  I want to tag my questions

 Background:

  Scenario: adding tag results in that tag being displayed on the page
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I add tag "tag1" to problem "1"
    And I am on the problems page

  Scenario: remove tag
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I add tag "tag1" to problem "1"
    And I am on the problems page
    And I remove tag "1" from problem "1"
    And I am on the problems page

  Scenario: adding an existing tag to a question in the collection view

  Scenario: adding a new tag to a question in the collection view

  Scenario: adding an existing tag to a question in the question view

  Scenario: adding a new tag to a question in the question view
