Feature: display list of questions filtered by tag
  As an instructor
  So that I can quickly find questions appropriate for my class
  I want to find questions matching only certain tags

  Background:


  Scenario: restrict to questions with 'quiz 2' tag
    Given I am signed in with uid "1234" and provider "github"
    And I am on the CourseQuestionBank home page
    When I fill in "tags" with "quiz 2"
    And I press "Apply"
    Then I should see "quiz 1"
    And I should see "quiz 2"
    And I should not see "quiz 3"
    And I should not see "quiz 4"

  Scenario: searching for two tags
    Given I am signed in with uid "1234" and provider "github"
    And I am on the CourseQuestionBank home page
    When I fill in "tags" with "quiz 2,quiz 4"
    And I press "Apply"
