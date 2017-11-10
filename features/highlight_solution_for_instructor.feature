Feature: As an instructor, I should see the see the solution highlighted with each problem

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'bloom_test.txt'

  Scenario: I should see the solution highlighted in the given problem
    When I am on the CourseQuestionBank home page
    Then I should see soltuion "solution" highlighted
