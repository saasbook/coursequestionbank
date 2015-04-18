Feature: Export a collection
  As an instructor
  So I can publish a quiz
  I want to be export a collection

  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the dashboard

  Scenario: Export a quiz
    When I follow "1/22/15 (W1 L2)"
    And I follow "export button"
    Then I should see "1/22/15 (W1 L2)"
