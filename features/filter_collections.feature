Feature: User can filter questions by collection
  As an instructor,
  So that I can more easily find questions that I have organized,
  I want to be able to see questions from only certain collections


  Background:
    Given I am signed in with uid "1234" and provider "github"
    And I have uploaded 'micro_quizzes.txt'
    And I am on the CourseQuestionBank home page
    And I follow "View 60"


  Scenario: filter by one collection
    When I check "1/22/15 (W1 L2)"
    And I press "Search"
    Then I should see "Plan-and-Document (P&D) with Agile"
    And I should not see "In an HTML5 document"

  Scenario: filter by multiple collections
    When I check "1/22/15 (W1 L2)"
    And I check "1/29/15 (W2 L2): Ruby; HTTP/HTML/CSS basics"
    And I press "Search"
    Then I should see "Plan-and-Document (P&D) with Agile"
    And I should see "In an HTML5 document"
    And I should not see "Consider the following Ruby code"

  Scenario: filter using all collections
    When I check "All Collections"
    And I press "Search"
    Then I should see "Plan-and-Document (P&D) with Agile"
    And I should see "In an HTML5 document"
    And I should see "Consider the following Ruby code"
