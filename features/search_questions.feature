@search_questions
Feature: Search questions by question text
  As an instructor
  So that I can easily find questions
  I want to be able to search for questions by text

  As an instructor,
  So that I can find past questions when making an exam,
  I want to search questions by keywords and full text

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'foo.txt'
    And I am on the CourseQuestionBank home page
    And I follow "View 60"

  Scenario: searching by question text
    When I fill in "Search Keywords" with "HyperText Transfer Protocol"
    And I press "Search"
    Then I should see "RDBMS"
    And I should not see "implied port number"

  Scenario: search by both question text and tag
    When I fill in "Search Keywords" with "URI"
    And I fill in "Tags" with "test_tag"
    And I press "Search"
    Then I should see "implied port number"
    And I should not see "handling views"

  Scenario: search by text that doesn't match any questions (sad path)
    When I fill in "Search Keywords" with "Barney the purple dinosaur"
    And I press "Search"
    Then I should see "No questions matched your search criteria"
    And I should not see "handling views"
    And I should not see "implied port number"
    And I should not see "complicated to scale"
    And I should not see "An HTTP request"
