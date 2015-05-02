Feature: display list of questions filtered by tag
  As an instructor
  So that I can quickly find questions appropriate for my class
  I want to find questions matching only certain tags

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I am on the CourseQuestionBank home page
    And I fill in "add_tags_1" with "quiz 1"
    And I fill in "add_tags_1" with "quiz 4"
    And I fill in "add_tags_2" with "quiz 1"
    And I fill in "add_tags_1" with "quiz 2"
    

  Scenario: restrict to questions with 'quiz 2' tag
    When I fill in "tags" with "quiz 2"
    And I press "Apply"
    Then I should see "quiz 1"
    And I should see "quiz 2"
    And I should not see "quiz 3"
    And I should not see "quiz 4"

  Scenario: searching for two tags
    When I fill in "tags" with "quiz 2,quiz 4"
    And I press "Apply"


  



